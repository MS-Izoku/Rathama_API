# frozen_string_literal: true

class MonumentCard < Card
# region Card Type Validations
  # validate required data presence
  validates_presence_of :durability

  validates :attack, absence: true
  validates :health, absence: true
  validates :armor, absence: true

  # validate required base values of data
  validates :durability, numericality: { greater_than_or_equal_to: 1 }
# endregion
end
