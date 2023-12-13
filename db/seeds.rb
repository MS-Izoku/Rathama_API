require 'io/console'

# region Seed Text
class SeedText
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
# endregion


class SeedMethods
  
# region Fiends
  def self.seed_fiends
  end

  def self.drop_fiends
  end

# endregion

# region Spells
  def self.seed_spells
  end

  def self.drop_spell
  end
# endregion

# region Traps
  def self.seed_traps
  end

  def self.drop_traps
  end
# endregion

#region Monuments
  def self.seed_monuments
  end

  def self.drop_monuments
  end
#endregion



# region Heroes
  def self.seed_heroes
  end

  def self.drop_heroes
  end
# endregion



# region PlayerClasses
  def self.seed_player_classes
    @@player_class_data = {
      "Neutral": {
        id: 0,
        description: "No Class"
      },
      "Detainer": {
        id: 1,
        description: "A master of demons, who uses them at a cost to themselves for a greater reward"
      },
      "Keeper":{
         id: 2,
         description: "An overseer of the seal, capable of raising an army"
      },
      "Magus": {
         id: 3,
         description: "A spellcaster versed in many magics"
      },
      "Sage": {
         id: 4,
         description: "A master of body and soul, often native to Koden" 
      },
      "Seer": {
         id: 5,
         description: "One who sees the future, and prepares for it" 
      },
      "Trapper":{
         id: 6,
         description: "A well-versed demon hunter who prepares deadly traps"
      },
      "Warden": {
         id: 7,
         description: "A guardian who safeguards the seal" 
      },
      "Watcher": {
         id: 8,
         description: "An attendant of the seal who seeks new prey from the outside world" 
      }
    }

    @@player_class_data.each do |name, data|
      puts ">>> Creating PlayerClass: #{name}"
      new_class = PlayerClass.find_or_create_by(id: data[:id], name: name, description: data[:description])
      new_class.save
    end
  end

  def self.drop_player_classes
    total = PlayerClass.all.count
    PlayerClass.destroy_all
    puts ">> Dropped #{total} PlayerClasses"
  end
# endregion



# region Expansions
  def self.seed_expansions
    @@expansion_data = {
      "Core" => {
        id: 0,
        description: "Cards Included with the base version of the game.  Available to all players for free.",
        tagline: "Core of the Game"
      }
    }

    total = 0
    @@expansion_data.each do |name, data|
      puts "Creating PlayerClass: #{name}"
      new_class = Expansion.new(id: data[:id], name: name, description: data[:description], tagline: data[:tagline])
      total += 1
      new_class.save
    end

    puts "Created #{total} PlayerClasses"

  end

  def self.drop_expansions
    total = Expansion.all.count
    Expansion.delete_all
    puts ">> Dropped #{total} PlayerClasses"
  end
# endregion

end

class ModelSeedController
  attr_reader :model_name

  def initialize(model_name = "Undefined Model Name" , seed_proc = nil , drop_proc = nil)
    @model_name = model_name
    @seed_proc = seed_proc.nil? ? proc { puts "No Seed Method Set" } : seed_proc
    @drop_proc = drop_proc.nil? ? proc { puts "No Drop Method Set" } : drop_proc
  end

  def create_model
    puts "> Seeding #{@model_name}"
    @seed_proc.call
  end

  def drop_model
    puts "> Dropping existing records of #{@model_name}"
    @drop_proc.call
  end
end


class SeedPerform
  def self.run
    system('cls')
    puts "Constructing SeedPerform...\n"

    all_seeders = SeedPerform.create_all_seeders

    puts "\nRunning Seed\n"
    all_seeders.each do |seeder|
      seeder.create_model
    end
  end

  def self.create_all_seeders
    all_seeders = []
    
    expansion_seeder = ModelSeedController.new("Expansions", proc { SeedMethods.seed_expansions}, proc { SeedMethods.drop_expansions})
    all_seeders << expansion_seeder
    puts "> Created Seeder for 'Expansions'"
    

    player_class_seeder = ModelSeedController.new("Player Classes", proc { SeedMethods.seed_player_classes}, proc { SeedMethods.drop_player_classes})
    puts "> Created Seeder for 'Player Classes'"
    all_seeders << player_class_seeder

    all_seeders
  end
end


SeedPerform.run