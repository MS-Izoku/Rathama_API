# frozen_string_literal: true

class UserCurrency < ApplicationRecord
  belongs_to :user
  belongs_to :currency

  validates :user_id, uniqueness: { scope: :currency_id, message: 'has already been taken for this currency' }
end
