class QuestsController < ApplicationController
  def give_player_quest
    return render json: { error: 'Quest not Found' }, status: :not_found if Quest.find_by(id: quest_params[:quest_id])
    return render json: { error: 'Player not Found' }, status: :not_found if Quest.find_by(id: quest_params[:user_id])

    @player_quest = PlayerQuest.new(player_quest_params)
    if @player_quest.save!
      render json: @player_quest
    else
      render json: { error: 'Failed to Save PlayerQuest', messages: @player_quest.errors.full_messages }
    end
  end

    # def give_player_weekly_quests
    #     return render json: {error: "User not Found" }, status: :not_found if User.find_by(id: params[:id]).nil?
    #     @quests = Quest.order("RANDOM()").limit(3)

    #     @player_quests = []
    #     @quests.each do |quest|
    #         new_pq = PlayerQuest.create!(user_id: params[:id], quest_id: quest.id)
    #         @player_quests << new_pq
    #     end

    #     render json: @player_quests
    # end

  def give_player_weekly_quests
    user = User.find_by(id: params[:id])
    return render json: { error: 'User not Found' }, status: :not_found if user.nil?

    ActiveRecord::Base.transaction do
      @quests = Quest.where(quest_type: "Weekly").order('RANDOM()').limit(3)
      @player_quests = []
      @quests.each do |quest|
        new_pq = PlayerQuest.create!(user_id: user.id, quest_id: quest.id)
        @player_quests << new_pq
      end
    end

    render json: @player_quests
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end


  def create; end

  def update; end

  def destroy; end

  private

  def quest_params
    params.require(:quest).permit(:name, :description, :target_completion_value)
  end

  def player_quest_params
    params.require(:player_quest).permit(:quest_id, :user_id)
  end
end
