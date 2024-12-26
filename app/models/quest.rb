# frozen_string_literal: true

class Quest < ApplicationRecord
  has_many :player_quests
  has_many :users, through: :player_quests

  validate :validate_quest_type

  # auto-sets the expiration time before save if the quest is set to expire
  before_create :auto_set_expiration

  has_many :rewards, as: :rewardable # quests can have many kinds of rewards, which means they belong to the rewardable ploymprhic class

  # all types of Quests that can exist
  def quest_types
    %w[Daily Weekly Monthly Seasonal Special]
  end

  # get an array of a number of x-type of Quests, or if the quantity is 1, just that record
  def self.random(current_quest_type = 'Daily', quantity = 1, exception = nil)
    raise StandardError, 'Invalid Quantity' if quantity <= 0

    if quantity > 1
      Quest.where(quest_type: current_quest_type)
           .where.not(id: exception&.id) # Exclude the exception quest if provided
           .order('RANDOM()')
           .limit(quantity)

    else
      quests = Quest.where(quest_type: current_quest_type)
                    .where.not(id: exception&.id) # Exclude the exception quest if provided
                    .order('RANDOM()')
                    .limit(1)
      quests.first
    end
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
