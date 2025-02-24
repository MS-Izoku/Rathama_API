# frozen_string_literal: true

# this is the main runner that looks for data in the local db/seeds directory
# seed each type separately
require Rails.root.join('lib/seed_runner')
SeedRunner.run
