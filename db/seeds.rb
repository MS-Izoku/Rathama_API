# frozen_string_literal: true

# this is the main runner that looks for data in the local db/seeds directory
# seed each type separately
require Rails.root.join('lib/seed_runner')

User.create(username: "TestUser", password: "password", email: "email@email.com")

interactive = ENV['INTERACTIVE'].to_s.downcase == 'true'
SeedRunner.run(interactive)

# move this out as needed
ExpansionGroup.find_or_create_by(name: '2025', year: 2025, icon_url: '')
evergreen = ExpansionGroup.find_or_create_by(name: 'Evergreen', year: 2025, icon_url: '')
basic = Expansion.first
basic.expansion_group_id = evergreen.id
basic.save
