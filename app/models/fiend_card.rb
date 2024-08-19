# A Class representing a playable Fiend Card in Rathama
# Fiend Cards can be played to the board-space for a cost
class FiendCard < Card
  has_many :tribes, -> { where(type: 'Tribe') }, class_name: 'CardTypeAttribute'

# region: Card Type Validation
  # validate required data presence
  validates_presence_of :attack, :health

  # validate absence of data
  validates :armor, absence: true
  validates :durability, absence: true

  # validate required base values of data
  validates :attack, numericality: { greater_than_or_equal_to: 0 }
  validates :health, numericality: { greater_than_or_equal_to: 1 }
# endregion

  def tribe_names
    card_type_attributes.pluck(:name)
  end
end
