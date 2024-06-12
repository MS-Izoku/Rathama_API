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

namespace :backup_cards do
  BACKUP_PREFIX = "(¤§§¤)>»»"
  
  desc "Create a backup JSON file for existing Card Data"
  task create: :environment do

    puts "#{BACKUP_PREFIX} Creating Backup JSON file for all Cards in Database"

    begin
      cards = {
        heroes: HeroCard.all,
        fiends: FiendCard.all,
        monuments: MonumentCard.all,
        spells: SpellCard.all,
        traps: TrapCard.all,
        weapons: WeaponCard.all
      }

      # Specify the full path to the backup JSON file
      file_path = 'cards_backup.json'

      # Open the file in write mode with the 'w' option to clear it before writing
      File.open(file_path, 'w') do |file|
        # Pretty-print the JSON data
        file.write(JSON.pretty_generate(cards.as_json))
      end

      puts "#{BACKUP_PREFIX} Created Backup JSON at #{file_path}"
    rescue => e
      puts "#{BACKUP_PREFIX} An error occurred: #{e.message}"
    end
  end

end
