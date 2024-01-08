# a class representing a playable Spell Card in Rathama
# Shares most behaviour programatically with TrapCards
class SpellCard < Card
  has_many :spell_schools, -> { where(type: 'SpellSchool') }, class_name: 'CardTypeAttribute'

# region Card Type Validation
  # Card Type Validation (validates fields based on card_type)# validate absence of data
  validates :attack, absence: true
  validates :health, absence: true
  validates :armor, absence: true
  validates :durability, absence: true
# endregion

  def spell_school_names
    spell_schools.pluck(:name)
  end
end
