class PlayerQuest < ApplicationRecord
    belongs_to :user
    belongs_to :quest

    before_create :copy_target_completion_rate

    private
    def copy_target_completion_rate
        self.target_completion_rate = quest.target_completion_rate
    end
end
