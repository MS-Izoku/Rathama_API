# frozen_string_literal: true

# a class representing a playable Trap Card in Rathama
# Shares most behaviour programatically with SpellCards
class TrapCard < Card
  has_many :spell_schools, -> { where(type: 'SpellSchool') }, class_name: 'CardTypeAttribute'

# region Validations
  # Card Type Validation (validates fields based on card_type)
  validates :attack, absence: true
  validates :health, absence: true
  validates :armor, absence: true
  validates :durability, absence: true
# endregion

  def spell_school_names
    spell_schools.pluck(:name)
  end
end
