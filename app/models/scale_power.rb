class ScalePower < ApplicationRecord
    belongs_to :player_class

    validates :name, :unique => true
    validates :description, presence: true
    validates :cost, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
end
