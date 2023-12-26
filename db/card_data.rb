class CardData
  attr_reader :cards

  def self.parse_card_data_csv
  end

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

  def self.spell_schools
    [
        "Arcane" , "Earth" , "Fire" , "Ice" , "Light" , "Magic",  "Shadow"  , "Life", "Wind"
    ]
  end

  # Undead, Quillboar, Elemental, Beast, Mech, xMurloc, Totem, xDragon, Naga, xxDemon, Pirate
  def self.tribes
    {
        "Aquatic": "",
        "Beast": "",
        "Dragon": "",
        "Flying": "",
        "Ghost": "",
        "Primal": "",
        "All": "",
    }
  end
end
