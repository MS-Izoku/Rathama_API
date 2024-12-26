# frozen_string_literal: true

class ConnectedCard < ApplicationRecord
  belongs_to :master_card, class_name: 'Card', foreign_key: 'master_card_id'
  belongs_to :child_card, class_name: 'Card', foreign_key: 'child_card_id'
end
