class HeroCard < Card

  # validate required data presence
  validates_presence_of :armor

  # validate absence of data
  validates :attack, absence: true
  validates :health, absence: true
  validates :durability, absence: true

  # validate required base values of data
  validates :armor, numericality: { greater_than_or_equal_to: 0 }
end
