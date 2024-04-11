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

# region: Card Generation




# endregion

# region: Seed Config
generate_test_user = true
generate_random_base_cards = true
generate_deck_size_cards = true
generate_player_classes = true
# endregion




def generate_random_string(length)
  characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  random_string = ''

  length.times do
    random_string << characters[rand(characters.length)]
  end

  random_string
end

if generate_test_user
  User.create(username: "TestUser123", email: "testemail123@email.com", password: "Password1!")
end

if generate_random_base_cards
  30.times do |card|
    card_name = generate_random_string(12)
    card = SpellCard.new(
      name: card_name,
      cost: 0,
      flavor_text: "Testing Card Generation #{card_name}",
      card_art_url: "shouldgohere#{card_name}",
      expansion_id: 0,
      rarity: 'Common',
      is_generated_card: false,
      card_text: 'Test Me Baby!'
    )
  
    if card.save
      puts card.name + ' was generated!'
    else
      puts "Failed to save #{card.name}"
      card.errors.each do |error|
        p error
      end
    end
  end
end

if generate_deck_size_cards
  # Add to Deck Limit
    SpellCard.create(
      name: 'Add 20',
      cost: 0,
      flavor_text: 'Testing Card Generation ADD',
      card_art_url: 'shouldgohere ADD',
      expansion_id: 0,
      rarity: 'Common',
      is_generated_card: false,
      card_text: 'Test Me Baby!',
      deck_size_modifier_type: 'Add',
      deck_size_modifier_value: '20'
    )

  # Reduce Deck Limit
    subtractor_card = SpellCard.create(
      name: 'Subtract 15',
      cost: 0,
      flavor_text: 'Testing Card Generation SUBTRACTOR',
      card_art_url: 'shouldgohere SUBTRACTOR',
      expansion_id: 0,
      rarity: 'Common',
      is_generated_card: false,
      card_text: 'Test Me Baby!',
      deck_size_modifier_type: 'Subtract',
      deck_size_modifier_value: '15'
    )

  # Override Deck Limit
  override_card = SpellCard.create(
    name: 'Overrride Deck Size',
    cost: 0,
    flavor_text: 'Testing Card Generation OVERRIDE',
    card_art_url: 'shouldgohere OVERRIDE',
    expansion_id: 0,
    rarity: 'Common',
    is_generated_card: false,
    card_text: 'Test Me Baby!',
    deck_size_modifier_type: 'Override',
    deck_size_modifier_value: '15'
  )

end

if generate_player_classes
  PlayerClass.create(name: "Neutral", description: "True Neutral", id: 0)
  PlayerClass.create(name: "Magus", description: "Blue")
  PlayerClass.create(name: "Detainer", description: "Purple / Black")
  PlayerClass.create(name: "Warden", description: "Red")
  PlayerClass.create(name: "Sage", description: "White (Brown / Metal)")
  PlayerClass.create(name: "Trapper", description: "Green")
end
