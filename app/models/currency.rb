# frozen_string_literal: true

class Currency < ApplicationRecord
  has_many :quest_rewards, as: :rewardable
  has_many :user_currencies
  has_many :users, through: :user_currencies # get all players that have currencies (in case it has not been initialized)

    # grant currency this to a specific user
  def grant(user, amount = 0)
    user_currency = UserCurrency.find_or_create_by(user_id: user.id, currency_id: id)
    user_currency.quantity = user_currency.quantity + amount.clamp(0, Float::INFINITY)
    user_currency.save
    user_currency.quantity # return the new quantity the user has
  end

  def self.grant(user, currency_id, amount = 0)
    currency = Currency.find_by(id: currency_id)
    currency.grant(user, amount) # returns the quantity the user has
  end
end
