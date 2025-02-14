module Cocktails
  class Container < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true
  end
end
