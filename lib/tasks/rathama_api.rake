namespace :db do
  desc 'Rebuild the database (drop and recreate)'
  task :rebuild, [:args] => :environment do |_t, _args|
    system('cls')
    # Execute `rails db:drop:_unsafe` command
    puts '[== Resetting Database ==]'
    puts ''
    sh 'rails db:drop:_unsafe'

    # Execute `rails db:migrate` command
    puts ''
    puts '[== Performing Migrations ==]'
    puts ''
    sh 'rails db:migrate'

    puts ''
    puts '[== Seeding Database ==]'
    puts ''
    sh 'rails db:seed'

    puts ''
    puts '[== Database Reset Complete ==]'
  end
end

namespace :cache do
  CACHE_LOG_PREFIX = "(¤>>»"

  # initialize caching for both production and development setups
  desc 'Initialize Caching'
  task :initialize do
    return if Rails.application.config.action_controller.perform_caching
    puts "#{CACHE_LOG_PREFIX} Initializing Cache for Environment::Dev"
    sh 'rails dev:cache'

    #puts "#{CACHE_LOG_PREFIX} Initializing Cache for Environment::Production"
    #sh 'rails production:cache'  
  end



  desc 'Disable Cache'
  task :disable do
    return unless Rails.application.config.action_controller.perform_caching
    puts "#{CACHE_LOG_PREFIX} Disabling Rathama Cache"
  end


  desc 'Clear Cache'
  task clear: :environment do
    puts "#{CACHE_LOG_PREFIX} Clearing Existing Rathama Cache"
    Rails.cache.clear
    puts "#{CACHE_LOG_PREFIX} Cache has been Cleared"
  end
end
