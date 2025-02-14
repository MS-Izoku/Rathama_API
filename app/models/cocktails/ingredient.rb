module Cocktails
  class Ingredient < ApplicationRecord
    has_many :cocktail_ingredients, class_name: 'Cocktails::CocktailIngredient'
    has_many :cocktails, through: :cocktail_ingredients, class_name: 'Cocktails::Cocktail'

    validates :name, presence: true
    validates :type, presence: true
  end
end
