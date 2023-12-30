# Once-per-turn use abilities, often asscociated with HeroCards
class ScalePower < ApplicationRecord

# region: relationships
  belongs_to :player_class
  belongs_to :hero_card, optional: true
# endregion
  

# region: Validations
  validates :name, unique: true
  validates :description, presence: true
  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0 }
# endregion


end
