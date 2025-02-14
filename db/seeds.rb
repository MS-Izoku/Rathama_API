def create_card_types
  # region: Card Type Attribute
  puts 'Creating Tribes...'

  angelic = Tribe.find_or_create_by!(name: 'Angelic', description: 'Those that resemble angels, or mock them')
  aquatic = Tribe.find_or_create_by!(name: 'Aquatic', description: 'Those that dwell underwater')
  chimera = Tribe.find_or_create_by!(name: 'Chimera', description: 'Beats and those who resemble them')
  dream = Tribe.find_or_create_by!(name: 'Dream',
                                   description: 'Strange, sometimes Eldritch creatures that often defy even the most vivid imagination')
  ghost = Tribe.find_or_create_by!(name: 'Ghost',
                                   description: 'Those that resemble the undead or ghastly creatures from beyond')
  golem = Tribe.find_or_create_by!(name: 'Golem', description: 'Constructs given what some would consider life')
  mimic = Tribe.find_or_create_by!(name: 'Mimic', description: 'Those who imitate the humanoid or bipedal shape')

  puts "Created #{Tribe.all.count} Tribes"

# spell schools
  puts 'Creating Spell Schools...'
  alchemic = SpellSchool.find_or_create_by!(name: 'Alchemic',
                                            description: 'Potions and circle-based spells which involve exhanges.  Equivilent exchange if you will')
  magic = SpellSchool.find_or_create_by!(name: 'Magic',
                                         description: 'What many would consider stereotypical magic.  Chants and intellect are a defining factors, but at a cost.')
  chakra = SpellSchool.find_or_create_by!(name: 'Chakra',
                                          description: 'The magic of the body, internal workings made manifest.  Often exhausting, but with uniquely regenerative and body-enhancing capabilities.')
  illusion = SpellSchool.find_or_create_by!(name: 'Illusion',
                                            description: "Forcing the enemy to see what you want them to see, or perhaps yourself if you're clever.")

  divine = SpellSchool.find_or_create_by!(name: 'Divine',
                                          description: 'Spells that invoke the power of the gods themselves, rare and powerful')
  talismanic = SpellSchool.find_or_create_by!(name: 'Talismanic',
                                              description: 'Spells invoked from powerful artifacts, which do not make great or useful weapons.  Possibly expendable or cheap.')

# Elements
  fire = SpellSchool.find_or_create_by!(name: 'Fire', description: 'Spells that control the element of fire')
  ice = SpellSchool.find_or_create_by!(name: 'Ice', description: 'Spells that control the element of ice and water')
  earth = SpellSchool.find_or_create_by!(name: 'Earth',
                                         description: 'Spells that control the element of Earth and Metal')
  wood = SpellSchool.find_or_create_by!(name: 'Wood',
                                        description: 'Spells that focus on the power of wood (and plants)')
  wood = SpellSchool.find_or_create_by!(name: 'Wind',
                                        description: 'Spells that focus on the power of wood (and plants)')
  lightning = SpellSchool.find_or_create_by!(name: 'Lightning',
                                             description: 'Spells that control the element of Lightning')
  shadow = SpellSchool.find_or_create_by!(name: 'Shadow', description: 'Spells that control the element of Shadow')

  puts "Created #{Tribe.all.count} Tribes"

# endregion
end

def create_cocktail_containers
  # Hard
  Cocktail::Container.create('Champagne Flute',
                             description: 'The narrow opening and the elongated shape of this glass prevent the bubbles of champagne and sparkling wines from disappearing quickly, keeping the effervescence, or perlage, longer than the classic cup.', category: 'Hard')
  Cocktail::Container.create('Rocks Glass',
                             description: 'Short, sturdy glass typically used for serving spirits neat, on the rocks, or in short cocktails.', category: 'Hard')
  Cocktail::Container.create('Old Fashioned Glass',
                             description: 'Also called Double “On-the-Rocks” glass, it is suitable for drinking liqueurs or spirits with plenty of ice, the lowballs.', category: 'Hard')
  Cocktail::Container.create('Double Old Fashioned Glass',
                             description: 'The classic “On-the-Rocks” glass for larger lowballs, providing extra capacity for ice and mixers.', category: 'Hard')
  Cocktail::Container.create('Cosmopolitan Glass',
                             description: 'A variation of the martini glass with a slightly more rounded bowl, often used for serving cocktails like the Cosmopolitan.', category: 'Hard')
  Cocktail::Container.create('Collins Glass',
                             description: 'Has an ideal shape to enjoy collins and a wide range of refreshing long drinks.', category: 'Hard')
  Cocktail::Container.create('Brandy Snifter',
                             description: 'The pot-bellied bowl of this glass is designed to capture the aroma of brandy and spirits.', category: 'Hard')
  Cocktail::Container.create('Wobble Cognac Glass',
                             description: 'A unique glass with a rounded base that allows it to wobble, enhancing the aeration of cognac.', category: 'Hard')
  Cocktail::Container.create('Tulip Glass',
                             description: 'Its flared rim and bulbous shape are designed to capture aroma and maintain head retention in beers or spirits.', category: 'Hard')
  Cocktail::Container.create('Grappa Glass',
                             description: 'Tall, narrow glass designed to concentrate the aromas of grappa and other aromatic spirits.', category: 'Hard')
  Cocktail::Container.create('Pousse Cafe Glass',
                             description: 'A narrow, tall glass used for layered cocktails, typically consisting of liqueurs with different densities.', category: 'Hard')
  Cocktail::Container.create('Cordial Glass',
                             description: 'Small, stemmed glass designed for serving sweet or fortified liqueurs in small quantities.', category: 'Hard')
  Cocktail::Container.create('Vodka Glass',
                             description: 'A small, thick-walled glass designed to maintain the temperature of chilled vodka.', category: 'Hard')
  Cocktail::Container.create('Absinthe Glass',
                             description: 'A specialized glass with a reservoir at the bottom for measuring the correct amount of absinthe, often used with a sugar spoon.', category: 'Hard')
  Cocktail::Container.create('Liqueur Glass',
                             description: 'Small glass designed for sipping liqueurs (especially if sweet and not very aromatic). It can have different shapes and does not always have a stem.', category: 'Hard')
  Cocktail::Container.create('Shooter Glass',
                             description: 'Slightly taller than a shot glass, designed for serving layered or mixed shooter drinks.', category: 'Hard')
  Cocktail::Container.create('Shot Glass',
                             description: 'Used essentially for small quantities of alcohol to drink in a single sip: some bartenders use it as a measuring cup; it has a capacity of 45ml.', category: 'Hard')

  # Mixed
  Cocktail::Container.create('Margarita Glass',
                             description: 'Explicitly designed for the tequila-based cocktail from which it takes its name, this glass is also ideal for serving a wide range of frozen drinks.', category: 'Mixed')
  Cocktail::Container.create('Irish Coffee Glass',
                             description: 'Resistant to heat, this glass with stem and handle is ideal for serving a wide range of hot drinks.', category: 'Mixed')
  Cocktail::Container.create('Goblet Glass',
                             description: 'A wide-bowled glass that is used for a variety of mixed drinks or specialty cocktails.', category: 'Mixed')
  Cocktail::Container.create('Sour Glass',
                             description: 'Similar to a Flute but with a more squat shape, it is the ideal glass for Sours and Crusta cocktails, frosted ones garnished with spirals of lemon peel.', category: 'Mixed')
  Cocktail::Container.create('Highball Glass',
                             description: 'This is the glass for plentiful drinks with ice.', category: 'Mixed')
  Cocktail::Container.create('Martini Glass',
                             description: 'Equipped with a conical stem and cup, the glass is par excellence for serving cocktails, shaken and mixed.', category: 'Mixed')
  Cocktail::Container.create('Milkshake Glass',
                             description: 'A tall, flared glass used for serving milkshakes or thick blended cocktails.', category: 'Mixed')
  Cocktail::Container.create('Punch Glass',
                             description: 'Similar to a miniature teacup (but without a saucer), it is often crystal and usually accompanied by a punch bowl in the same style.', category: 'Mixed')
  Cocktail::Container.create('Hurricane Glass',
                             description: 'Invented recently for the famous New Orleans cocktail from which it takes its name, it is also ideal for a wide range of frozen and tropical drinks.', category: 'Mixed')
  Cocktail::Container.create('Poco Grande Glass',
                             description: 'A smaller version of the hurricane glass, often used for tropical cocktails or frozen drinks.', category: 'Mixed')
  Cocktail::Container.create('Glass Pousse-café',
                             description: 'This glass from narrow walls and straight used layered cocktails based on liqueurs which, when poured, overlap without mixing.', category: 'Mixed')
  Cocktail::Container.create('Parfait Glass',
                             description: 'This elegant shot glass serves some dessert wines and liqueur-based drinks.', category: 'Mixed')

  # Beer
  Cocktail::Container.create('Pokal Glass',
                             description: 'A stemmed beer glass with a rounded bowl, often used for lagers and bocks.', category: 'Beer')
  Cocktail::Container.create('Zombie Glass',
                             description: 'A tall glass used for tiki drinks, particularly the Zombie cocktail.', category: 'Beer')
  Cocktail::Container.create('Weizen Glass',
                             description: 'A tall, curvy glass used for wheat beers, designed to enhance the aroma and foam.', category: 'Beer')
  Cocktail::Container.create('Pilsner Glass',
                             description: 'This large, eye-catching beer glass, specially created for the Czech Pilsner Lager, is used for any beer.', category: 'Beer')
  Cocktail::Container.create('Sling Glass',
                             description: 'A tall, narrow glass typically used for gin slings and similar mixed drinks.', category: 'Beer')
  Cocktail::Container.create('Pint Glass',
                             description: 'A simple, cylindrical glass commonly used for serving draft beers.', category: 'Beer')
  Cocktail::Container.create('Flagon',
                             description: 'A large container with a handle, typically made of glass or ceramic, used for serving beer.', category: 'Beer')
  Cocktail::Container.create('Beer Mug',
                             description: 'This large glass with a handle takes on a more inviting appearance when left to freeze. However, there are several types of beer glass.', category: 'Beer')
  Cocktail::Container.create('Tankard',
                             description: 'A traditional beer mug with a sturdy handle, often made from metal or ceramic.', category: 'Beer')
  Cocktail::Container.create('Stein',
                             description: 'A German-style beer mug with a hinged lid, typically made from ceramic.', category: 'Beer')

  # Wine
  Cocktail::Container.create('White Wine Glass',
                             description: 'Slightly smaller (and often opening narrower) than the glass of red wine, goes well for a few mixes with ice.', category: 'Wine')
  Cocktail::Container.create('Red Wine Glass',
                             description: 'The bigger of the two standard glasses of wine used to serve red wine, as its name indicates, it is also suitable for some tropical drinks and wine-based cocktails like sangria.', category: 'Wine')
  Cocktail::Container.create('Balloon Wine Glass',
                             description: 'A large-bowled glass that allows for full aeration of wines, especially reds with bold flavors.', category: 'Wine')
  Cocktail::Container.create('Sherry Glass',
                             description: 'This elegant stemmed glass, created for sipping Sherry, can replace the liqueur glass.', category: 'Wine')
  Cocktail::Container.create('Wine Tasting Glass',
                             description: 'A smaller glass with a narrow opening, designed for wine tasting to concentrate the aroma.', category: 'Wine')
end

def create_general_spirits
  Cocktail::Spirit.create(name: 'Whiskey',
                          description: 'A basic spirit made with [fill that in with some other description, maybe mention aging if important]')
  Cocktail::Spirit.create(name: 'Vodka',
                          description: 'A basic spirit made with [fill that in with some other description, maybe mention aging if important]')
  Cocktail::Spirit.create(name: 'Gin',
                          description: 'A basic spirit made with [fill that in with some other description, maybe mention aging if important]')
  Cocktail::Spirit.create(name: 'Malort',
                          description: 'A basic spirit made with [fill that in with some other description, maybe mention aging if important]')
  Cocktail::Spirit.create(name: 'Campari',
                          description: 'A basic spirit made with [fill that in with some other description, maybe mention aging if important]')
  Cocktail::Spirit.create(name: 'Cognac',
                          description: 'A basic spirit made with [fill that in with some other description, maybe mention aging if important]')
  Cocktail::Spirit.create(name: 'Vermouth',
                          description: 'A basic spirit made with [fill that in with some other description, maybe mention aging if important]')
  Cocktail::Spirit.create(name: 'Gin',
                          description: 'A basic spirit made with [fill that in with some other description, maybe mention aging if important]')
  Cocktail::Spirit.create(name: 'Rum',
                          description: 'A basic spirit made with [fill that in with some other description, maybe mention aging if important]')
  Cocktail::Spirit.create(name: 'Bourbon',
                          description: 'A basic spirit made with [fill that in with some other description, maybe mention aging if important]')
  Cocktail::Spirit.create(name: 'Scotch',
                          description: 'A basic spirit made with [fill that in with some other description, maybe mention aging if important]')
  Cocktail::Spirit.create(name: 'Tequila',
                          description: 'A basic spirit made with [fill that in with some other description, maybe mention aging if important]')
  Cocktail::Spirit.create(name: 'Amaretto',
                          description: 'A basic spirit made with [fill that in with some other description, maybe mention aging if important]')
  Cocktail::Spirit.create(name: 'Absinthe',
                          description: 'A basic spirit made with [fill that in with some other description, maybe mention aging if important]')
  Cocktail::Spirit.create(name: 'Rye',
                          description: 'A basic spirit made with [fill that in with some other description, maybe mention aging if important]')
  Cocktail::Spirit.create(name: 'Pisco',
                          description: 'A basic spirit made with [fill that in with some other description, maybe mention aging if important]')
  Cocktail::Spirit.create(name: 'Armagnac',
                          description: 'A basic spirit made with [fill that in with some other description, maybe mention aging if important]')
  Cocktail::Spirit.create(name: 'Mezcal',
                          description: 'A basic spirit made with [fill that in with some other description, maybe mention aging if important]')
end

def create_general_mixers
  Cocktail::Mixer.create(name: 'Tonic Water', description: '')
  Cocktail::Mixer.create(name: 'Soda Water', description: '')
  Cocktail::Mixer.create(name: 'Ginger Ale', description: '')
  Cocktail::Mixer.create(name: 'Ginger Beer', description: '')
  Cocktail::Mixer.create(name: 'Cola', description: '')
  Cocktail::Mixer.create(name: 'Lemon-Lime Soda', description: '')
  Cocktail::Mixer.create(name: 'Horchata', description: '')
  Cocktail::Mixer.create(name: 'Sparkling Water', description: '')
  Cocktail::Mixer.create(name: 'Hop Water', description: '')
  Cocktail::Mixer.create(name: 'Water', description: '')
  Cocktail::Mixer.create(name: 'Lemon Juice', description: '')
  Cocktail::Mixer.create(name: 'Lime Juice', description: '')
  Cocktail::Mixer.create(name: 'Orange Juice', description: '')
  Cocktail::Mixer.create(name: 'Grapefruit Juice', description: '')
  Cocktail::Mixer.create(name: 'Yuzu Juice', description: '')
end
