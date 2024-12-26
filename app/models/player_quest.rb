# frozen_string_literal: true

class PlayerQuest < ApplicationRecord
  MAX_DAILY_QUESTS = 3
  MAX_WEEKLY_QUESTS = 3
  MAX_MONTHLY_QUESTS = 2
  MAX_SEASONAL_QUESTS = 2

  belongs_to :user
  belongs_to :quest

  before_create :copy_target_completion_rate
  validate :validate_quest_count

  # NYI <<<==============
  def complete
    # Give player rewards depending on reward type
    quest.rewards.each do |reward|
      reward.grant_to(user)
    end

    # Additional logic for completing the quest
    self.completed_at = DateTime.current
    save

    # Optionally destroy the PlayerQuest if needed
    destroy
  end

  def self.grant_quests(user_id, target_quest_type = 'Daily', quantity = 1)
    @player_quests = []
    ActiveRecord::Base.transaction do
      @quests = Quest.random(target_quest_type, quantity)
      @quests.each do |quest|
        new_pq = PlayerQuest.create!(user_id:, quest_id: quest.id)
        @player_quests << new_pq
      end
    end

    @player_quests
  end

  private

  def copy_target_completion_rate
    self.target_completion_value = quest.target_completion_value
  end

  def validate_quest_count
    current_quests = PlayerQuest.where(user_id:)
    return if current_quests.count.zero?

    other_quests_of_type = user.quests.where(quest_type: quest.quest_type)

    if quest.quest_type == 'Weekly' && other_quests_of_type.count >= MAX_WEEKLY_QUESTS
      errors.add(:base, 'Too Many Weekly Quests')
    elsif quest.quest_type == 'Daily' && other_quests_of_type.count >= MAX_DAILY_QUESTS
      errors.add(:base, 'Too Many Weekly Quests')
    elsif quest.quest_type == 'Monthly' && other_quests_of_type.count >= MAX_MONTHLY_QUESTS
      errors.add(:base, 'Too Many Monthly Quests')
    elsif quest.quest_type == 'Seasonal' && other_quests_of_type.count >= MAX_SEASONAL_QUESTS
      errors.add(:base, 'Too Many Seasonal Quests')
    end
  end
end
