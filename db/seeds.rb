require 'io/console'
require_relative './card_data'
require 'csv'

# NOTE: Rails 7 switched out byebug with => binding.break

class SeedText
  # region: titles
  def self.main_title
    <<-TEXT
      _________________________________________________________________
      [#=#]~[#=#]~[#=#]~[#=#]~[#=#]~[#=#]~[#=#]~[#=#]~[#=#]~[#=#]~[#=#]
      =================================================================#{'   '}
              ______      _   _#{'                           '}
              | ___ \\    | | | |#{'                          '}
              | |_/ /__ _| |_| |__   __ _ _ __ ___   __ _#{' '}
              |    // _` | __| '_ \\ / _` | '_ ` _ \\ / _` |
              | |\\ \\ (_| | |_| | | | (_| | | | | | | (_| |
              \\_| \\_\\__,_|\\__|_| |_|\\__,_|_| |_| |_|\\__,_|

                  (O==[(=::, Beasts of the Seal '::=)]==O)
      _________________________________________________________________
      [#=#]~[#=#]~[#=#]~[#=#]~[#=#]~[#=#]~[#=#]~[#=#]~[#=#]~[#=#]~[#=#]
      =================================================================#{'  '}

    TEXT
  end

  def self.fiend_title
    <<-TEXT

      [x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]
                  ____, ____, ____, ____,   ____,
                  (-|_, (-|   (-|_, (-|  |  (-|  \\
                  _|    _|__, _|__, _|  |_, _|__/
                  (     (     (     (       (#{'     '}
      [x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]

    TEXT
  end

  def self.spell_title
    <<-TEXT

      [x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]
                  ____  ___, ____, __    __#{'   '}
                  (-(__`(-|_)(-|_, (-|   (-|#{'   '}
                  ____) _|   _|__, _|__, _|__,
                  (     (    (     (     (#{'     '}
      [x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]

    TEXT
  end

  def self.trap_title
    <<-TEXT

      [x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]
                      ____, ___,   ___,   ___,
                  (-|   (-|_)  (-|_\\_,(-|_)
                      _|    _| \\_, _|  )  _|#{'  '}
                  (     (      (      (#{' '}
      [x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]

    TEXT
  end

  def self.monument_title
    <<-TEXT

      [x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]
      _____,   ____, ____,   __   _, _____,   ____, ____,   ____,
      (-| | |  (-/  \\(-|  |  (-|  |  (-| | |  (-|_, (-|  |  (-|#{'   '}
      _| | |_,  \\__/ _|  |_,  |__|_, _| | |_, _|__, _|  |_, _|#{'   '}
      (              (               (        (     (       (#{'     '}
      [x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]

    TEXT
  end

  def self.hero_title
    <<-TEXT

      [x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]
                  __   _, ____, ___,   ____,
                  (-|__|  (-|_, (-|_)  (-/  \\
                  _|  |_, _|__, _| \\_,  \\__/
                  (       (     (#{'            '}
      [x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]

    TEXT
  end
  # endregion

  def self.tribes_title
    <<-TEXT
    [x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x][x]x[x]x[x]x[x]x[x]x[x]
    ------------------------------------------------------------------------------

                    ████████╗██████╗ ██╗██████╗ ███████╗███████╗
                    ╚══██╔══╝██╔══██╗██║██╔══██╗██╔════╝██╔════╝
                        ██║   ██████╔╝██║██████╔╝█████╗  ███████╗
                        ██║   ██╔══██╗██║██╔══██╗██╔══╝  ╚════██║
                        ██║   ██║  ██║██║██████╔╝███████╗███████║
                        ╚═╝   ╚═╝  ╚═╝╚═╝╚═════╝ ╚══════╝╚══════╝
    ______________________________________________________________________________
    [x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x][x]x[x]x[x]x[x]x[x]x[x]
    TEXT
  end

  def self.spell_schools_title
    <<-TEXT
    [x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x][x]x[x]x[x]x[x]x[x]x[x]
    ------------------------------------------------------------------------------
          _____               _  _  _____        _                    _#{'      '}
        /  ___|             | || |/  ___|      | |                  | |#{'     '}
        \\ `--.  _ __    ___ | || |\ `--.    ___ | |__    ___    ___  | | ___#{' '}
          `--. \\| '_ \\  / _ \\| || | `--. \\ / __|| '_ \\  / _ \\  / _ \\ | |/ __|
        /\\__/ /| |_) ||  __/| || |/\\__/ /| (__ | | | || (_) || (_) || |\\__ \\
        \\____/ | .__/  \\___||_||_|\\____/  \\___||_| |_| \\___/  \\___/ |_||___/
                | |#{'                                                          '}
                |_|#{'      '}
    ______________________________________________________________________________
    [x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x][x]x[x]x[x]x[x]x[x]x[x]
    TEXT
  end

  def self.card_type_attributes_title
    <<-TEXT
    [x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x][x]x[x]x[x]x[x]x[x]x[x]
    ------------------------------------------------------------------------------
      ___   __   ____  ____  ____  _  _  ____  ____#{'                                           '}
      / __) / _\\ (  _ \\(    \\(_  _)( \\/ )(  _ \\(  __)#{'                                          '}
    ( (__ /    \\ )   / ) D (  )(   )  /  ) __/ ) _)#{'                                           '}
      \\___)\\_/\\_/(__\\_)(____/ (__) (__/  (__)  (____)#{'                                          '}
                      __   ____  ____  ____   __   ____  _  _  ____  ____  ____#{' '}
                ___   / _\\ (_  _)(_  _)(  _ \\ (  ) (  _ \\/ )( \\(_  _)(  __)/ ___)
              (___) /    \\  )(    )(   )   /  )(   ) _ () \\/ (  )(   ) _) \\___ \\
                    \\_/\\_/ (__)  (__) (__\\_) (__) (____/\\____/ (__) (____)(____/
    ______________________________________________________________________________
    [x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x]x[x][x]x[x]x[x]x[x]x[x]x[x]
    TEXT
  end

  def self.inline_title_1(title)
    <<-TEXT
      <>+(O]|==~=={_}}-     #{title}   -{{_}==~==|[O)+<>
    TEXT
  end

  def self.inline_title_2(title)
    <<-TEXT
              ==== #{title} ====
    TEXT
  end

  def self.inline_title_3(title)
    <<-TEXT
      .:*~*:._.:*~*:._.:*~*:. #{title} .:*~*:._.:*~*:._.:*~*:.
    TEXT
  end

  def self.message(text, level = 1)
    msg = ''
    level.times { |_i| msg += '>' }
    "#{msg} #{text}"
  end
end

class SeedMethods
  # region Fiends
  def self.seed_fiends; end

  def self.drop_fiends; end

  # endregion

  # region Spells
  def self.seed_spells; end

  def self.drop_spells; end
  # endregion

  # region Traps
  def self.seed_traps; end

  def self.drop_traps; end
  # endregion

  # region Monuments
  def self.seed_monuments; end

  def self.drop_monuments; end
  # endregion

  # region Heroes
  def self.seed_heroes; end

  def self.drop_heroes; end
  # endregion

  # region PlayerClasses

  def self.seed_player_classes
    CardData.player_class_data.each do |name, data|
      puts ">>> Creating PlayerClass: #{name}"
      new_class = PlayerClass.find_or_create_by(id: data[:id], name:, description: data[:description])

      puts ">>>>> [Created New PlayerClass] #{new_class.name}: [#{new_class.description}]" if new_class.save
    end
  end

  def self.drop_player_classes
    total = PlayerClass.all.count
    PlayerClass.destroy_all
    puts ">> Dropped #{total} PlayerClasses"
  end
  # endregion

# region: Tribes and Spell Schools

  def self.drop_tribes
    puts ''
    puts '>> Dropping Tribes [CardTypeAttribute]'
    total = Tribe.all.count
    Tribe.destroy_all
    puts ">> Dropped #{total} Tribes"
    puts ''
  end

  def self.drop_spell_schools
    puts ''
    puts '>> Dropping SpellSchools [CardTypeAttribute]'
    total = PlayerClass.all.count
    PlayerClass.destroy_all
    puts ">> Dropped #{total} SpellSchools"
    puts ''
  end

  def self.drop_card_type_attributes
    puts "Dropping ALL CardTypeAttributes [#{CardTypeAttributes.all.count}]"
    CardTypeAttributes.all.count
    CardTypeAttributes.destroy_all
    puts ">> Dropped #{CardTypeAttributes.all.count} CardTypeAttributes"
    puts ''
  end

# endregion

# region: Expansions
  def self.seed_expansions
    @@expansion_data = {
      'Core' => {
        id: 0,
        description: 'Cards Included with the base version of the game.  Available to all players for free.',
        tagline: 'Core of the Game'
      }
    }

    total = 0
    @@expansion_data.each do |name, data|
      puts "Creating PlayerClass: #{name}"
      expansion = Expansion.new(id: data[:id], name:, description: data[:description], tagline: data[:tagline])
      total += 1
      expansion.save
    end

    puts "Created #{total} Expansions"
  end

  def self.drop_expansions
    total = Expansion.all.count
    Expansion.delete_all
    puts ">> Dropped #{total} PlayerClasses"
  end
  # endregion

  # region: Scale Powers
  def self.seed_scale_powers; end

  def self.drop_expansions
    total = Expansion.all.count
    Expansion.delete_all
    puts ">> Dropped #{total} PlayerClasses"
  end
# endregion

# region: PlayerClasses
  def seed_player_classes
    created = 0
    failed = 0
    failed_names = []

    puts '>> Creating Player Classes'

    CardData.player_class_data.each do |player_class_name, description|
      puts ">>> Creating Player Class: #{player_class_name}"
      player_class = PlayerClass.find_or_create_by(name: player_class_name, description:)
      puts ">>>>> Created Player Class: #{player_class.name} | #{player_class.description}"
    rescue StandardError
      failed += 1
      failed_names << player_class_names
    end

    puts ''
    puts "Created #{created} PlayerClasses"
    puts "Failed to created #{failed} PlayerClasses"
    puts failed_names.flatten
    puts ''
  end

  def drop_player_classes
    puts "Attempting to drop #{PlayerClass.all.count} PlayerClasses"
    PlayerClass.destroy_all
    puts "Player classes dropped, #{PlayerClass.all.count} remain"
    puts ''
  end

# endregion
end

class ModelSeedController
  attr_reader :model_name

  def initialize(model_name = 'Undefined Model Name', seed_proc = nil, drop_proc = nil)
    @model_name = model_name
    @seed_proc = seed_proc.nil? ? proc { puts 'No Seed Method Set' } : seed_proc
    @drop_proc = drop_proc.nil? ? proc { puts 'No Drop Method Set' } : drop_proc
  end

  def create_model
    puts "> Seeding #{@model_name}"
    @seed_proc.call
  end

  def drop_model
    puts "> Dropping existing records of #{@model_name}"
    @drop_proc.call
  end

  def create_from_csv
    system('cls')
    script_directory = File.dirname(__FILE__)
    csv_filename = './cards.csv'
    csv_file_path = File.join(script_directory, csv_filename)

    puts 'attempting to load file at: ' + csv_file_path

    # Read and parse the CSV file with headers
    CSV.foreach(csv_file_path, headers: true) do |row|
      puts "Row: #{row.inspect}"
    end
  end
end

# p CardData.all_cards

# ModelSeedController.new.create_from_csv

CardData.seed_tribes
CardData.seed_spell_schools
CardData.seed_player_classes
CardData.create_keywords_from_csv
CardData.create_cards_from_csv
