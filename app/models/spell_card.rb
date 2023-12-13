class SpellCard < Card
  
  # validate absence of data
  validates :attack, absence: true
  validates :health, absence: true
  validates :armor, absence: true
  validates :durability, absence: true
end
