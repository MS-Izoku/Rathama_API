class Quest < ApplicationRecord
    has_many :player_quests
    has_many :users, through: :player_quests

    def quest_types
        ["Daily", "Weekly", "Monthly", "Seasonal", "Special"]
    end
end
