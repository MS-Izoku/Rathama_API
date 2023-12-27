class TrapCard < Card
  has_many :spell_schools, -> { where(type: 'SpellSchool') }, class_name: 'CardTypeAttribute'

  # validate absence of data
  validates :attack, absence: true
  validates :health, absence: true
  validates :armor, absence: true
  validates :durability, absence: true

  def spell_school_names
    spell_schools.pluck(:name)
  end
end
