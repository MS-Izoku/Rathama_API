# frozen_string_literal: true

require 'io/console'

namespace :db do
  desc 'Rebuild the database (drop and recreate)'
  task :rebuild, [:args] => :environment do |_t, _args|
    system('cls')
    # Execute `rails db:drop:_unsafe` command
    puts '[== Resetting Database ==]'
    puts ''
    sh 'rails db:drop:_unsafe'

    sh 'rails db:create'

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

namespace :server do
  desc 'Kill Server by PID'
  task :kill_pid do
    pid = ARGV[1]&.to_i

    if pid.nil? || pid <= 0
      puts 'Usage: rake server:kill_pid <PID>'
      exit 1
    end

    puts "Attempting to kill process with PID: #{pid}..."
    system("taskkill /F /PID #{pid}")

    # Ensure Rake doesn't process PID as a task name
    begin
      Rake::Task[:server].invoke
    rescue StandardError
      nil
    end
  end

  # for when rails is telling you the server is running, even after you kill the PID
  desc 'Delete Rails server PID file'
  task :clear_pid do
    pid_file = 'tmp/pids/server.pid'
    if File.exist?(pid_file)
      File.delete(pid_file)
      puts "Deleted PID file: #{pid_file}"
    else
      puts "No PID file found at #{pid_file}"
    end
  end
end

namespace :cache do
  CACHE_LOG_PREFIX = '(¤>>»'

  # initialize caching for both production and development setups
  desc 'Initialize Caching'
  task :initialize do
    return if Rails.application.config.action_controller.perform_caching

    puts "#{CACHE_LOG_PREFIX} Initializing Cache for Environment::Dev"
    sh 'rails dev:cache'

    # puts "#{CACHE_LOG_PREFIX} Initializing Cache for Environment::Production"
    # sh 'rails production:cache'
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

namespace :backup do
  BACKUP_PREFIX = '(¤§=BACKUP=§¤)>»»'

  desc 'Create a backup JSON file for existing Card Data'
  task create_json: :environment do
    system('cls')
    puts "#{BACKUP_PREFIX} Creating Non-User data Backup JSON"
    data = BackupRegenerator.create_db_json
    counts = BackupRegenerator.count_records(data)

    counts.each do |record_name, count|
      puts "#{BackupRegenerator.printable_arrows(2)}#{BACKUP_PREFIX} Created #{count} #{BackupRegenerator.snake_to_camel(record_name.to_s)}"
    end
  end

  desc 'Create a backup CSV file for existing Card Data'
  task create_csv: :environment do
    system('cls')
    puts "#{BACKUP_PREFIX} Creating Non-User data Backup CSV"
    data = BackupRegenerator.create_db_csv
    counts = BackupRegenerator.count_records(data)

    counts.each do |record_name, count|
      puts "#{BackupRegenerator.printable_arrows(2)}#{BACKUP_PREFIX} Created [#{count}] #{BackupRegenerator.snake_to_camel(record_name.to_s)}"
    end
  end

  desc 'Repopulate the Database using a backup JSON file (for non-user data)'
  task restore_from_json: :environment do
    system('cls')

    migrate_flag = ENV['migrate'] == 'true'
    if migrate_flag
      puts "#{BACKUP_PREFIX} Running migrations..."
      Rake::Task['db:migrate'].invoke
    else
      puts "#{BACKUP_PREFIX} WARNING:: Unapplied migrations may cause errors when attempting to restore the backup after a drop. Add the 'migrate=true' flag to automatically migrate changes"
    end

    file_path = ENV['file_path']
    if file_path
      # Ensure the file exists before attempting to restore
      if File.exist?(file_path)
        puts "#{BACKUP_PREFIX} Recreating Database using JSON File from #{file_path}"
        BackupRegenerator.restore_game_data_from_json(file_path)
      else
        puts "#{BACKUP_PREFIX} Error: File does not exist at #{file_path}"
        return
      end
    else
      data = BackupRegenerator.restore_game_data_from_json
      data.each do |record_name, count|
        puts "#{BackupRegenerator.printable_arrows(2)}#{BACKUP_PREFIX} Created [#{count}] #{BackupRegenerator.snake_to_camel(record_name.to_s)}"
      end

    end
  end

  desc 'Repopulate the Database using a backup CSV file (for non-user data)'
  task restore_from_csv: :environment do
    system('cls')

    migrate_flag = ENV['migrate'] == 'true'
    if migrate_flag
      puts "#{BACKUP_PREFIX} Running migrations..."
      Rake::Task['db:migrate'].invoke
    else
      puts "#{BACKUP_PREFIX} WARNING:: Unapplied migrations may cause errors when attempting to restore the backup after a drop. Add the 'migrate=true' flag to automatically migrate changes"
    end

    file_path = ENV['file_path']
    if file_path
      # Ensure the file exists before attempting to restore
      if File.exist?(file_path)
        puts "#{BACKUP_PREFIX} Recreating Database using CSV File from #{file_path}"
        BackupRegenerator.restore_game_data_from_csv(file_path)
      else
        puts "#{BACKUP_PREFIX} Error: File does not exist at #{file_path}"
        return
      end
    else
      data = BackupRegenerator.restore_game_data_from_csv
      data.each do |record_name, count|
        puts "#{BackupRegenerator.printable_arrows(2)}#{BACKUP_PREFIX} Created [#{count}] #{BackupRegenerator.snake_to_camel(record_name.to_s)}"
      end
    end
  end
end

# Make a nicer version of this later
ADMIN_ROOT_USERNAME = 'radmin_01'
namespace :admin do
  task create_local_admin: :environment do
    User.create(ADMIN_ROOT_USERNAME)
    ApiKey.create
  end
end
