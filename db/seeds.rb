# region: Card Type Attribute

angelic = Tribe.create!(name: 'Angelic', description: 'Those that resemble angels, or mock them')
aquatic = Tribe.create!(name: 'Aquatic', description: 'Those that dwell underwater')
chimera = Tribe.create!(name: 'Chimera', description: 'Beats and those who resemble them')
dream = Tribe.create!(name: 'Dream',
                      description: 'Strange, sometimes Eldritch creatures that often defy even the most vivid imagination')
ghost = Tribe.create!(name: 'Ghost', description: 'Those that resemble the undead or ghastly creatures from beyond')
golem = Tribe.create!(name: 'Golem', description: 'Constructs given what some would consider life')
mimic = Tribe.create!(name: 'Mimic', description: 'Those who imitate the humanoid or bipedal shape')

# spell schools
alchemic = SpellSchool.create!(name: 'Alchemic',
                               description: 'Potions and circle-based spells which involve exhanges.  Equivilent exchange if you will')
magic = SpellSchool.create!(name: 'Magic',
                            description: 'What many would consider stereotypical magic.  Chants and intellect are a defining factors, but at a cost.')
chakra = SpellSchool.create!(name: 'Chakra',
                             description: 'The magic of the body, internal workings made manifest.  Often exhausting, but with uniquely regenerative and body-enhancing capabilities.')
illusion = SpellSchool.create!(name: 'Illusion',
                               description: "Forcing the enemy to see what you want them to see, or perhaps yourself if you're clever.")

divine = illusion = SpellSchool.create!(name: 'Divine',
                                        description: 'Spells that invoke the power of the gods themselves, rare and powerful')

# Elements
fire = SpellSchool.create!(name: 'Fire', description: 'Spells that control the element of fire')
ice = SpellSchool.create!(name: 'Ice', description: 'Spells that control the element of ice and water')
earth = SpellSchool.create!(name: 'Earth', description: 'Spells that control the element of Earth and Metal')
wood = SpellSchool.create!(name: 'Wood', description: 'Beasts')
lightning = SpellSchool.create!(name: 'Lightning', description: 'Spells that control the element of Lightning')
shadow = SpellSchool.create!(name: 'Shadow', description: 'Spells that control the element of Shadow')

# endregion
