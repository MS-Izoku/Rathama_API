# A class representing a playable Hero card in Rathama
class HeroCard < Card

# region: Card Type Validations
  # validate required types
  validates_presence_of :armor

  # validate absence of data
  validates :attack, absence: true
  validates :health, absence: true
  validates :durability, absence: true
# endreigon

  # validate required base values of data
  validates :armor, numericality: { greater_than_or_equal_to: 0 }
end
