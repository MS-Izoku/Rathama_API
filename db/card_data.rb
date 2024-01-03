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
    {
      # Magic Types
      "Arcane": "Spells and Traps relating to the performance of Magic, typically using Mana",
      "Alchemic": "Spells and Traps rooted in the use of Alchemy, both spiritual and physical",
      "Sen": "Spells and Traps rooted in the use of Sage Arts",

      # elements
      "Earth": "Spells and Traps relating to the element of Earth" ,
      "Fire": "Spells and Traps relating to the element of Fire" ,
      "Ice": "Spells and Traps relating to the element of Water and Ice" ,
      "Life": "Spells and Traps relating to the element of Life and Nature",
      "Lightning": "Spells and Traps relating to the elements of Thunder and Lightning",
      "Light": "Spells and Traps relating to the element of Light",
      "Metal": "Spells and Traps relating to the element of Metal",
      "Shadow": "Spells and Traps relating to the element of Shadow" ,
      "Wind": "Spells and Traps relating to the element of Wind and Air"

    }
  end

  # Undead, Quillboar, Elemental, Beast, Mech, -, Totem, -, Naga, -, Pirate
  def self.tribes
    {
        "Aquatic": "Fiends which reside in the Oceans and Waters",
        "Chimera": "Fiends which resemble Animals",
        "Dragon": "Fiends which resemble Reptilian Creatures",
        "Flying": "Fiends which are able to Fly",
        "Ghost": "Fiends which are notably etherial or resemble the living dead",
        "Primal": "Fiends which have similarities to elements or elemental creatures",
        "Eldritch": "Fiends which have similarities to otherworldly entities, incomprehensible to sane minds",
        "All": "Fiends which have all possible tribes",
    }
  end

  def self.player_class_data
     {
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
  end
end
