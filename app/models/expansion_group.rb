# An Expansion Group is a group of related expansions, normally used to denotate when cards should rotate
class ExpansionGroup < ApplicationRecord
    has_many :expansions

    validates :name, uniqueness: true
    validates :year, numericality: { greater_than_or_equal_to: 2024 }
end
