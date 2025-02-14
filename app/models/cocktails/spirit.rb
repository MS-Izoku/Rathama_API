module Cocktails
  class Spirit < Ingredient
    validates :alcohol_content, presence: true, numericality: { greater_than: 0 }
    validates :unit, inclusion: { in: units }

    def self.units
      %w[oz ml cl parts dash splash jigger shot tbsp tsp cup]
    end
  end
end
