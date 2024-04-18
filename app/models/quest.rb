class Quest < ApplicationRecord
  has_many :player_quests
  has_many :users, through: :player_quests

  validate :validate_quest_type

  # auto-sets the expiration time before save if the quest is set to expire
  before_create :auto_set_expiration

  has_many :rewards, as: :rewardable # quests can have many kinds of rewards, which means they belong to the rewardable ploymprhic class

  def quest_types
    %w[Daily Weekly Monthly Seasonal Special]
  end

  private

  def auto_set_expiration
    return unless can_expire

    self.expiration = case quest_type
                      when 'Daily'
                        DateTime.current
                      when 'Weekly'
                        DateTime.current
                      else
                        DateTime.current if expiration.nil?
                      end
  end

  def validate_quest_type
    errors.add(:base, 'Invalid Quest-Type') unless quest_types.include?(quest_type)
  end
end
