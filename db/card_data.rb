# frozen_string_literal: true

class CardData
  attr_reader :cards

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
    puts keyword_data[1..].class
    # Iterate over the remaining rows and create keywords
    keyword_data[1..].map do |row|
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

# region Player Classes
  def self.seed_player_classes
    pc_data = {
      "Detainer": { description: '' },
      "Keeper": { description: '' },
      "Magus": { description: '' },
      "Sage": { description: '' },
      "Seer": { description: '' },
      "Trapper": { description: '' },
      "Warden": { description: '' },
      "Watcher": { description: '' }
    }

    puts 'Preparing to Seed Player Classes'
    pc_data.each do |name, data|
      pc = PlayerClass.find_by(name:)
      if pc.nil?
        puts "Creating PlayerClass => #{name}"
        PlayerClass.create(name:, description: data[:description])
      else
        pc.assign_attributes(description(data[:description]))
        if pc.changes?
          pc.save
          puts "Updating Player Class => #{name}"
        else
          pc.reload
        end
      end
    end
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
end
