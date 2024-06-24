class QuestsController < ApplicationController
  before_action :authenticate_user, only: %i[give_player_weekly_quests give_player_quest reroll_player_quest]


  def give_player_quest
    return render json: { error: 'Quest not Found' }, status: :not_found if Quest.find_by(id: quest_params[:quest_id])

    @player_quest = PlayerQuest.new(quest_id: player_quest_params, user_id: @current_user.id)
    if @player_quest.save!
      render json: @player_quest
    else
      render json: { error: 'Failed to Save PlayerQuest', messages: @player_quest.errors.full_messages }
    end
  end


  def give_player_random_daily_quest
    daily_quest_count = current_user.quests.where(quest_type: 'Daily').count
    return { error: 'Daily Quests are Full' } if daily_quest_count >= 3

    @daily_quests = Quest.where(quest_type: 'Daily').order('RANDOM()').limit(3 - daily_quest_count)

    quests = @daily_quests.each do |new_quest|
      puts "Giving Player Quest ##{new_quest.id}"
      PlayerQuest.create!(quest_id: new_quest.id, user_id: current_user.id)
    end

    render json: quests
  end


  def give_all_players_random_daily_quest
    User.all.each do |user|
      @daily_quest = Quest.where(quest_type: 'Daily').order('RANDOM()').limit(3)
      @player_quest = PlayerQuest.new(quest_id: @daily_quest.id, user_id: user.id)

      if @player_quest.save!
        render json: @player_quest
      else
        render json: { error: 'Failed to Save PlayerQuest', messages: @player_quest.errors.full_messages }
      end
    end
  end


  def reroll_player_quest
    @current_player_quest = PlayerQuest.find_by(id: replace_player_quest_params[:player_quest_id])
    return render json: {error: "Quest not Found"}, status: :not_found unless @current_player_quest


    if @current_player_quest.user.id != @current_user.id
      return render json: { error: "Cannot Reroll Another Player's Quests" }, status: :unauthorized
    end

    ActiveRecord::Base.transaction do
      # get a random quest that the current player does not have
      new_quest = Quest.where(quest_type: @current_player_quest.quest.quest_type)
      .where.not(id: @current_player_quest.quest.id)
      .order('RANDOM()')
      .limit(1)
      .first

      @new_player_quest = PlayerQuest.new(user_id: @current_user.id, quest_id: new_quest.id)

      @current_player_quest.destroy
      @new_player_quest.save
    rescue StandardError => e
      ActiveRecord::Base.connection.rollback_db_transaction
      return render json: { error: "Failed to Reroll Quest::#{e.message}" }
    end

    render json: { new_quest: @new_player_quest, replaced: @current_player_quest }
  end


# region Quest Granting
  def give_player_daily_quest
    quests_to_grant_count = current_user.last_daily_quest_given_date.nil ? 3 : 1

    @player_quests = PlayerQuest.grant_quests(current_user.id, "Daily", quests_to_grant_count)

    render json: @player_quests
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end


  def give_player_weekly_quests
    @player_quests = PlayerQuest.grant_quests(current_user.id, "Weekly", 3)

    render json: @player_quests
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end


  def give_player_monthly_quests
    @player_quests = PlayerQuest.grant_quests(current_user.id, "Monthly", 2)

    render json: @player_quests
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
# endregion

  def show_player_quests
    player_quests = PlayerQuest.includes(:quest).references(:quests).where(user_id: current_user.id)

    if player_quests.empty?
      render json: { error: 'Player Quests are Nil' }, status: :not_found
    else
      grouped_quests = player_quests.group_by { |player_quest| player_quest.quest.quest_type.downcase }

      grouped_serialized = grouped_quests.transform_values do |quests|
        QuestsOnLoginSerializer.many(quests)
      end

      render json: grouped_serialized
    end
  end


  def add_quest_progress
    @player_quest = PlayerQuest.find_by(id: quest_progression_params[:id])

    return render json: { error: "Quest not Found" } unless @player_quest

    @player_quest.current_completion_value += quest_progression_params[:completion_value]
    @player_quest.current_completion_value = @player_quest.current_completion_value.clamp(0 , @player_quest.target_completion_value)    
    @player_quest.is_completed = @player_quest.current_completion_value >= @player_quest.target_completion_value
    @player_quest.save

    @player_quest.complete if @player_quest.is_completed


    render json: {
      quest: PlayerQuestSerializer.one(@player_quest),
      completed: @player_quest.is_completed
    }
  end

  

# region: Quest CRUD

  def show
    @quest = Quest.find_by(id: params[:id])
    if @quest.nil
      render json: { error: 'Quest not Found' }, status: :not_found
    else
      render json: @quest
    end
  end

  def create
    @quest = Quest.new(quest_params)
    if @quest.save
      render json: @quest, status: :created
    else
      render json: { errors: @quest.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @quest = Quest.find_by(id: params[:id])
    if @quest.update(quest_params)
      render json: { quest: @quest, status: 'Destroyed' }
    else
      render json: { error: @quest.errors.full_messages, status: 'Failed to Destroy' }
    end
  end

  def destroy
    @quest = Quest.find_by(id: params[:id])
    if @quest.destroy
      render json: { quest: @quest, status: 'Destroyed' }
    else
      render json: { error: @quest.errors.full_messages, status: 'Failed to Destroy' }
    end
  end

# endregion

  private

  def quest_params
    params.require(:quest).permit(:name, :description, :target_completion_value)
  end

  def player_quest_params
    params.require(:player_quest).permit(:quest_id, :user_id)
  end

  def replace_player_quest_params
    params.require(:player_quest).permit(:player_quest_id)
  end

  def quest_progression_params
    params.require(:player_quest).permit(:id, :completion_value)
  end

end
