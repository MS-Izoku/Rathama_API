# frozen_string_literal: true

class Reward < ApplicationRecord
  belongs_to :rewardable, polymorphic: true
end
