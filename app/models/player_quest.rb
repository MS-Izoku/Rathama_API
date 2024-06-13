class PlayerQuest < ApplicationRecord
  MAX_DAILY_QUESTS = 3
  MAX_WEEKLY_QUESTS = 3

  belongs_to :user
  belongs_to :quest

  before_create :copy_target_completion_rate
  validate :validate_quest_count

  def complete
    all_rewards = quest.rewards
    # give player rewards depending on reward type
  end

  private

  def copy_target_completion_rate
    self.target_completion_value = quest.target_completion_value
  end

  def validate_quest_count

    current_quests = PlayerQuest.where(user_id: user_id)
    return if current_quests.count == 0

    my_quest_type = quest.quest_type
    
    other_quests_of_type = user.quests.where(quest_type: my_quest_type) #user.quests.where(quest_type: current_quests.quest.quest_type)

    p "=============================================================="
    p "==> My quest type is:: #{my_quest_type} and I have:: #{other_quests_of_type.count}"
    p "=============================================================="
   

    if my_quest_type == "Weekly" && other_quests_of_type.count >= MAX_WEEKLY_QUESTS
        errors.add(:base, "Too Many Weekly Quests")
    elsif my_quest_type == "Daily" && other_quests_of_type.count >= MAX_DAILY_QUESTS
        errors.add(:base, "Too Many Weekly Quests")
    end
  end
end
