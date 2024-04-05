class CardData
  attr_reader :cards

# region: Create Cards from CSV
  
  # read the CSV of Card Data
  def self.get_card_csv_data
    file_path = Rails.root.join('db', 'cards.csv')

    # Check if the file exists
    if File.exist?(file_path)
      # Read the CSV file
      CSV.read(file_path)
    else
      puts 'Keyword CSV Not Found'
      nil
    end
  end


  # Read the card CSV data and create cards from it
  def self.create_cards_from_csv
    # "Card Name" | "Player Class" | "Type" | "Cost" | "Flavor Text" | "Rarity" | Attack | Health | Armor | Durability | Expansion Id | Is Token? | Tribe or School | Inspiration

    card_data = CardData.get_card_csv_data
    return if card_data.nil?

    # Assuming the first row contains headers (Name, Description)
    headers = card_data.first

    generated_cards = 0
    updated_cards = 0
    skipped_cards = 0

    puts 'Reading Card File...'
    puts card_data[1..-1].class
    # Iterate over the remaining rows and create keywords
    cards = card_data[1..-1].map do |row|
      card_attributes = Hash[headers.zip(row)]

      existing_card = Card.find_by(name: card_attributes['Name'])
      # puts "Keyword: #{keyword_attributes} | #{keyword_attributes['Name']} #{keyword_attributes['Description']}"

      if existing_card.nil?
        puts 'Generating new Card'
        new_card = Card.create(name: keyword_attributes['Card Name'], type: keyword_attributes[""])
        generated_cards += 1
        puts new_card
      else
        # update the fields from the CSV

        existing_card.update()
        updated_cards += 1
      end
    end

    puts '[= Cards =]'
    puts "Generated: #{generated_cards}"
    puts "Updated: #{updated_cards}"
    puts "Skipped: #{skipped_cards}"
    puts '=============='

    nil
  end


  # validte and format incoming card-data to be added to or updated in the database
  def validate_csv_card_data(parsed_csv_card_data)
    valid_card_types = %[Fiend Spell Trap Weapon Monument]
    card_type = parsed_csv_card_data["Type"]
    is_valid_type = valid_card_types.include?(card_type)

    return false unless is_valid_type
    

    player_class_id = PlayerClass.find_by(name: parsed_csv_card_data["Card Name"]).id

    return {
      name: parsed_csv_card_data["Card Name"],
      type: card_type,
      cost: 0,
      flavor_text: "",
      rarity: "",
      attack: 0,
      health: 0,
      durability: 0,
      expansion_id: 0,
      is_generated_card: false,
      card_attributes: []
    }

  end


# endregion

  def self.create_cards
    cards = []
    cards.each do |player_class|
      player_class['Spells'].each do |spell|
      end

      player_class['Traps'].each do |trap|
      end

      player_class['Fiends'].each do |spell|
      end

      player_class['Heroes'].each do |trap|
      end

      player_class['Monuments'].each do |spell|
      end

      player_class['Weapons'].each do |trap|
      end
    end
  end


  def self.all_cards
    @@cards
  end


# region Keyword Data from CSV
  def self.get_keyword_csv_data
    file_path = Rails.root.join('db', 'keywords.csv')

    # Check if the file exists
    if File.exist?(file_path)
      # Read the CSV file
      CSV.read(file_path)

      # You can also render the data in a view if needed

    else
      puts 'Keyword CSV Not Found'
      nil
    end
  end


  def self.create_keywords_from_csv
    keyword_data = CardData.get_keyword_csv_data
    return if keyword_data.nil?

    # Assuming the first row contains headers (Name, Description)
    headers = keyword_data.first

    generated_keywords = 0
    updated_keywords = 0
    skipped_keywords = 0

    puts 'Reading Keyword File...'
    puts keyword_data[1..-1].class
    # Iterate over the remaining rows and create keywords
    keywords = keyword_data[1..-1].map do |row|
      keyword_attributes = Hash[headers.zip(row)]

      existing_keyword = Keyword.find_by(name: keyword_attributes['Name'])
      # puts "Keyword: #{keyword_attributes} | #{keyword_attributes['Name']} #{keyword_attributes['Description']}"

      if existing_keyword.nil?
        puts 'Generating new Keyword'
        new_keyword = Keyword.create(name: keyword_attributes['Name'], description: keyword_attributes['Description'])
        generated_keywords += 1
        puts new_keyword
      else
        current_description = existing_keyword.description
        if current_description == keyword_attributes['Description']
          puts "> (#{keyword_attributes['Name']}) No Fields to Update"
          skipped_keywords += 1
          next
        end

        existing_keyword.update(description: keyword_attributes['Description'])
        updated_keywords += 1
      end
    end

    puts '[= Keywords =]'
    puts "Generated: #{generated_keywords}"
    puts "Updated: #{updated_keywords}"
    puts "Skipped: #{skipped_keywords}"
    puts '=============='

    nil
  end
# endregion


# region Card Type Attributes (SpellSchools and Tribes)
  def self.seed_tribes_and_spell_schools
    tribe_data = CardData.read_local_csv("tribes_and_spell_schools.csv")
    CardData.seed_tribes
    CardData.seed_spell_schools
  end

  def self.seed_single_attribute(name, description, type)
    puts ">>>> Creating #{type}: #{name}"
      attribute = SpellSchool.find_or_create_by(name: name, description: description, type: type)
      if attribute.save
        puts ">>>>> [Created New #{type}] #{attribute.name}: [#{attribute.description}]"
      else
        puts "Failed to Create: #{name}"
        attribute.errors.each do |error|
          puts '>>> ' + error.full_message
        end        
      end
  end

  def self.seed_tribes(tribe_data)
    return if tribe_data.nil?

    puts ''
    puts '>> Seeding Tribes'

    
    total_created = 0
    failed = 0
    tribe_data.each do |name, description|
      puts ">>>> Creating Tribe: #{name}"
      tribe = Tribe.find_or_create_by(name:, description:)
      if tribe.save
        puts ">>>>> [Created New Tribe] #{tribe.name}: [#{tribe.description}]"
        total_created += 1
      else
        puts "Failed to Create #{name}"
        tribe.errors.each do |error|
          puts '>>> ' + error.full_message
        end
        failed += 1
      end
    end

    puts ">> Total Tribes Created from Hash: [#{total_created}]"
    puts ">> Total Tribes Failed: [#{failed}]"
  end


  def self.seed_spell_schools(spell_school_data)
    puts ''
    puts '>> Seeding Spell Schools'

    total_created = 0
    failed = 0
    CardData.spell_schools.each do |name, description|
      puts ">>>> Creating SpellSchool: #{name}"
      spell_school = SpellSchool.find_or_create_by(name:, description:)
      if spell_school.save
        puts ">>>>> [Created New SpellSchool] #{spell_school.name}: [#{spell_school.description}]"
        total_created += 1
      else
        puts "Failed to Create: #{name}"
        spell_school.errors.each do |error|
          puts '>>> ' + error.full_message
        end
        failed += 1
      end
    end

    puts ">> Total SpellSchools Created from Hash: [#{total_created}]"
    puts ">> Total SpellSchools Failed: [#{failed}]"
    puts ''
  end
# endregion


# region Get Google Sheet Data

  def get_keywords_from_google_sheets_api
    nil
  end


  def get_cards_from_google_sheets_api
    nil
  end


  def get_heroes_from_google_sheets_api
    nil
  end

# endregion



private
  
  def self.read_local_csv(csv_name)
    file_path = Rails.root.join('db', csv_name)

    # Check if the file exists
    if File.exist?(file_path)
      # Read the CSV file
      CSV.read(file_path)
    else
      puts "CSV Not Found [#{csv_name}] | [#{file_path}]"
      nil
    end
  end

end
