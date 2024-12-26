# frozen_string_literal: true

class QuestReward < ApplicationRecord
  belongs_to :quest
  belongs_to :reward
end
