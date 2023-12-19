class PlayerClass < ApplicationRecord
# region: relationships
    has_many :player_class_cards
    has_many :cards, through: :player_class_cards
# endregion

# region: Validations
    validates :name, uniqueness: true
# endregion
end
