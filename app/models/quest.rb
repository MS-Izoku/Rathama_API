class Quest < ApplicationRecord
    has_many :player_quests
    has_many :users, through: :player_quests
end
