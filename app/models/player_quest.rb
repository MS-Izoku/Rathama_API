class PlayerQuest < ApplicationRecord
  MAX_DAILY_QUESTS = 3
  MAX_WEEKLY_QUESTS = 3

  belongs_to :user
  belongs_to :quest

  before_create :copy_target_completion_rate
  before_create :validate_quest_count

  private

  def copy_target_completion_rate
    self.target_completion_rate = quest.target_completion_rate
  end

  def validate_quest_count
    quest_type = quest.quest_type
    quest_count = PlayerQuest.where(user_id: user.id).quests.where(quest_type:) # also cross-seach based on quest-type (Weekly/Daily)

    if quest_type == 'Daily'
      errors.add(:base, 'Daily Quest Cap Reached') if quest_count >= MAX_DAILY_QUESTS
    elsif quest_type == 'Weekly'
      errors.add(:base, 'Weekly Quest Cap Reached') if quest_count >= MAX_WEEKLY_QUESTS
    end
  end
end
