# frozen_string_literal: true

class AddLastDailyQuestGivenDateToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :last_daily_quest_given_date, :datetime
  end
end
