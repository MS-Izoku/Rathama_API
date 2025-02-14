module Cocktails
  class Cocktail < ApplicationRecord
    has_many :cocktail_ingredients, class_name: 'Cocktails::CocktailIngredient'
    has_many :ingredients, through: :cocktail_ingredients, class_name: 'Cocktails::Ingredient'

    # has a Container through CocktailContainer
    has_one :container, class_name: 'Cocktail::Container'
  end
end
