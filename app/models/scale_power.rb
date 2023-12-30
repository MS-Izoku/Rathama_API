class ScalePower < ApplicationRecord
  belongs_to :player_class
  belongs_to :hero_card, optional: true

  validates :name, unique: true
  validates :description, presence: true
  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
