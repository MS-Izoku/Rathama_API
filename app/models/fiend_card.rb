class FiendCard < Card
  has_many :tribes, -> { where(type: 'Tribe') }, class_name: 'CardTypeAttribute'

  # validate required data presence
  validates_presence_of :attack, :defense

  # validate absence of data
  validates :armor, absence: true
  validates :durability, absence: true

  # validate required base values of data
  validates :attack, numericality: { greater_than_or_equal_to: 0 }
  validates :health, numericality: { greater_than_or_equal_to: 1 }

  def tribe_names
    card_type_attributes.pluck(:name)
  end
end
