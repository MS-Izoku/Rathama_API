# frozen_string_literal: true

class WeaponCard < Card
  # validate required data presence
  validates_presence_of :durability
  validates_presence_of :attack

  # validate absence of data
  validates :health, absence: true
  validates :armor, absence: true

  # validate required base values of data
  validates :attack, numericality: { greater_than_or_equal_to: 0 }
  validates :durability, numericality: { greater_than_or_equal_to: 1 }
end
