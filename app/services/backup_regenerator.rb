require 'json'
require 'csv'

class BackupRegenerator
  DEFAULT_OUTPUT_DIR = Dir.pwd
  JSON_FILE_NAME = "db_backup.json"
  CSV_FILE_NAME = "db_backup.csv"

  # Restore non-user-related game data from JSON
  def self.restore_game_data_from_json
    # Implementation for restoring from JSON

    ActiveRecord::Base.transaction do
        begin
            restore_cards(backup_data['cards'])
            restore_player_classes(backup_data['player_classes'])
            restore_connected_cards(backup_data['connected_cards'])
            restore_scale_powers(backup_data['scale_powers'])
            restore_keywords(backup_data['keywords'])
            restore_expansions(backup_data['expansions'])
            restore_expansion_groups(backup_data['expansion_groups'])
            restore_tribes(backup_data['tribes'])
            restore_spell_schools(backup_data['spell_schools'])
            restore_currencies(backup_data['currencies'])
            restore_quests(backup_data['quests'])
            restore_rewards(backup_data['rewards'])

            # commit the transaction
            puts "Game data restored successfully from JSON!"
        rescue
            # rollback the transaction
            raise ActiveRecord::Rollback
        end
    end

  end

  # Restore non-user-related game data from CSV
  def self.restore_game_data_from_csv
    # Implementation for restoring from CSV
  end

  # Create a backup in CSV format
  def self.create_db_csv(output_dir = DEFAULT_OUTPUT_DIR)
    csv_data = format_data_for_csv
    write_to_file(File.join(output_dir, CSV_FILE_NAME), csv_data)
    puts "CSV backup created successfully at #{output_dir}/#{CSV_FILE_NAME}!"
  end

  # Create a backup in JSON format
  def self.create_db_json(output_dir = DEFAULT_OUTPUT_DIR)
    backup_data = game_data.to_json
    write_to_file(File.join(output_dir, JSON_FILE_NAME), backup_data)
    puts "JSON backup created successfully at #{output_dir}/#{JSON_FILE_NAME}!"
  end

  def self.game_data
    {
      # Core Card Data
      cards: Card.all.as_json,
      player_classes: PlayerClass.all.as_json,
      connected_cards: ConnectedCard.all.as_json,
      scale_powers: ScalePower.all.as_json,
      keywords: Keyword.all.as_json,

      # Expansions
      expansions: Expansion.all.as_json,
      expansion_groups: ExpansionGroup.all.as_json,

      # Card-Type Attributes
      tribes: Tribe.all.as_json,
      spell_schools: SpellSchool.all.as_json,

      # Currency
      currencies: Currency.all.as_json,

      # Quests and Rewards
      quests: Quest.all.as_json,
      rewards: Reward.all.as_json,
    }
  end

  private

  def self.read_json_file(file_name)
    file_path = File.join(Dir.pwd, file_name)
    return unless File.exist?(file_path)

    JSON.parse(File.read(file_path))
  end


  def self.read_csv_file(file_name)
    file_path = File.join(Dir.pwd, file_name)
    return unless File.exist?(file_path)

    # replace this with the CSV Reader
    #JSON.parse(File.read(file_path))
  end


  def self.write_to_file(file_name, data)
    File.open(file_name, "w") do |file|
      file.write(data)
    end
  end

  def self.format_data_for_csv
    CSV.generate do |csv|
      game_data.each do |key, records|
        csv << [key.to_s.upcase] # Add section header
        next if records.empty?

        # Add the CSV headers based on the attributes of the first record
        csv << records.first.keys

        # Add the data rows
        records.each do |record|
          csv << record.values
        end

        csv << [] # Add an empty line between sections
      end
    end
  end


# region: Restoration Methods
    def self.restore_cards(cards_data)
        cards_data.each {|card| Card.create!(card) }
    end

    def self.restore_player_classes(player_classes_data)
        player_classes_data.each {|player_class| PlayerClass.create!(player_class)}
    end

    def self.restore_connected_cards(data)
        data.each { |record| ConnectedCard.create!(record) }
    end

    def self.restore_scale_powers(data)
        data.each { |record| ScalePower.create!(record) }
    end

    def self.restore_keywords(data)
        data.each { |record| Keyword.create!(record) }
    end

    def self.restore_expansions(data)
        data.each { |record| Expansion.create!(record) }
    end

    def self.restore_expansion_groups(data)
        data.each { |record| ExpansionGroup.create!(record) }
    end

    def self.restore_tribes(data)
        data.each { |record| Tribe.create!(record) }
    end

    def self.restore_spell_schools(data)
        data.each { |record| SpellSchool.create!(record) }
    end

    def self.restore_currencies(data)
        data.each { |record| Currency.create!(record) }
    end

    def self.restore_quests(data)
        data.each { |record| Quest.create!(record) }
    end

    def self.restore_rewards(data)
        data.each { |record| Reward.create!(record) }
    end

# endregion

end