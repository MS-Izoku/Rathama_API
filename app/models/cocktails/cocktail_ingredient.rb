module Cocktails
  class CocktailIngredient < ApplicationRecord
    belongs_to :cocktail, class_name: 'Cocktails::Cocktail'
    belongs_to :ingredient, class_name: 'Cocktails::Ingredient'

    validates :quantity, presence: true
    validates :unit, presence: true
  end
end
