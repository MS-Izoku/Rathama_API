require 'io/console'
Dir[Rails.root.join('db/seeds/*.rb')].sort.each { |file| require file } # Require all seed files from db/seeds/

module SeedRunner
  # Hash where keys are seed classes and values determine whether they should run
  # Change to false to skip any of these seeds
  SEED_CLASSES = {
    SeedExpansions => true,
    SeedTribesAndSpellSchools => true,
    SeedCurrencies => true,
    SeedQuests => true,
    SeedPlayerClasses => true,
    SeedCardMechanics => true,
    SeedBasicCards => true
  }.freeze

  def self.run
    puts 'Initializing SeedRunner'
    puts create_sandwich_symbols('=')

    SEED_CLASSES.each do |klass, should_run|
      unless should_run # Skip if set to false
        print_seed_message("Skipping::#{klass.name}")
        next
      end

      print_seed_message("Seeding with File::#{klass.name}", 1, true)

      if klass.respond_to?(:seed)
        print_seed_message("Seeding::#{klass.name}", 2, true)
        klass.seed
        print_seed_message("Completed::#{klass.name}", 2, true)
      else
        print_seed_message("MethodMissing::#{klass} does not contain the class-level method #seed", 1)
      end
      create_sandwich_symbols(' ')
      create_sandwich_symbols
    rescue StandardError => e
      print_seed_message("Error::#{e.message}", 1)
      print_seed_message('Seeding has stopped', 1)
      create_sandwich_symbols(' ')

      break
    end
    print_seed_message('Seeding has Completed', 1)
    create_sandwich_symbols(' ')
  end

  def self.print_seed_message(message, level = 2, skip_break = false)
    puts "|#{'-' * level}> #{message}"
    puts create_sandwich_symbols('-') unless skip_break
  end

  def self.create_sandwich_symbols(symbol = '=')
    width = begin
      IO.console.winsize[1]
    rescue StandardError
      30
    end # Default to 30 if IO.console fails
    print "|#{symbol * (width - 2)}|" # Manually add a single newline
  end
end
