class Expansion < ApplicationRecord
    belongs_to :expansion_group
    validates :name, uniqueness: true

    def slug_name
        name.downcase.gsub(" " , "_")
    end
end
