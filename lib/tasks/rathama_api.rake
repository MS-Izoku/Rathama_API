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

  desc 'List all current '
end
