# frozen_string_literal: true

class SeedTribesAndSpellSchools
  def self.seed
    seed_spell_schools
    seed_tribes
  end
  
  def self.seed_spell_schools
    # region: spell schools
    SpellSchool.find_or_create_by(name: 'Alchemic',
                        description: 'Potions and circle-based spells which involve exhanges.  Equivilent exchange if you will')
    SpellSchool.find_or_create_by(name: 'Magic',
                        description: 'What many would consider stereotypical magic.  Chants and intellect are a defining factors, but at a cost.')
    SpellSchool.find_or_create_by(name: 'Chakra',
                        description: 'The magic of the body, internal workings made manifest.  Often exhausting, but with uniquely regenerative and body-enhancing capabilities.')
    SpellSchool.find_or_create_by(name: 'Illusion',
                        description: "Forcing the enemy to see what you want them to see, or perhaps yourself if you're clever.")

    SpellSchool.find_or_create_by(name: 'Divine',
                        description: 'Spells that invoke the power of the gods themselves, rare and powerful')
    SpellSchool.find_or_create_by(name: 'Talismanic',
                        description: 'Spells invoked from powerful artifacts, which do not make great or useful weapons.  Possibly expendable or cheap.')
    # endregion

    # Elements
    SpellSchool.find_or_create_by(name: 'Fire', description: 'Spells that control the element of fire')
    SpellSchool.find_or_create_by(name: 'Ice', description: 'Spells that control the element of ice and water')
    SpellSchool.find_or_create_by(name: 'Earth', description: 'Spells that control the element of Earth and Metal')
    SpellSchool.find_or_create_by(name: 'Wood', description: 'Beasts')
    SpellSchool.find_or_create_by(name: 'Lightning', description: 'Spells that control the element of Lightning')
    SpellSchool.find_or_create_by(name: 'Shadow', description: 'Spells that control the element of Shadow')
    # endregion
  end

  def self.seed_tribes
    Tribe.find_or_create_by(name: 'Angelic', description: 'Those that resemble angels, or mock them')
    Tribe.find_or_create_by(name: 'Aquatic', description: 'Those that dwell underwater')
    Tribe.find_or_create_by(name: 'Chimera', description: 'Beats and those who resemble them')
    Tribe.find_or_create_by(name: 'Dream',
                  description: 'Strange, sometimes Eldritch creatures that often defy even the most vivid imagination')
    Tribe.find_or_create_by(name: 'Ghost', description: 'Those that resemble the undead or ghastly creatures from beyond')
    Tribe.find_or_create_by(name: 'Golem', description: 'Constructs given what some would consider life')
    Tribe.find_or_create_by(name: 'Mimic', description: 'Those who imitate the humanoid or bipedal shape')
  end
end
