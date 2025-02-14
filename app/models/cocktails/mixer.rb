module Cocktails
  class Mixer < Ingredient
    validates :category, presence: true
    validates :unit, inclusion: { in: units }

    def self.units
      %w[oz ml cl parts dash splash jigger shot tbsp tsp cup]
    end
  end
end
