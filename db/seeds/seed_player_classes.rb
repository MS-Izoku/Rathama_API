# frozen_string_literal: true

class SeedPlayerClasses
  NEUTRAL_CLASS_NAME = 'Neutral'

  PLAYER_CLASS_IMAGE_PATH = Rails.root.join('db', 'seed_assets', 'player_classes')

  def self.seed
    create_initial_classes
    create_new_classes
  end

def self.create_initial_classes
  # setting Ids will be done manually here to prevent any weird asscociations
  unless PlayerClass.find_by(name: NEUTRAL_CLASS_NAME)
    neutral = PlayerClass.new(
      name: NEUTRAL_CLASS_NAME,
      description: 'Cards which can be used without a class restriction'
    )
    neutral.id = 0
    neutral.save!
  end

  detainer_class = PlayerClass.find_or_create_by(id: 1, name: 'Detainer', description: '')
  magus_class    = PlayerClass.find_or_create_by(id: 2, name: 'Magus', description: '')
  sage_class     = PlayerClass.find_or_create_by(id: 3, name: 'Sage', description: '')
  trapper_class  = PlayerClass.find_or_create_by(id: 4, name: 'Trapper', description: '')
  warden_class   = PlayerClass.find_or_create_by(id: 5, name: 'Warden', description: '')

  # Player Classes will require their own "Card" which is unobtainable by the player,
  # but is used by the game as the default Hero
  # the exception to this is the Neutral class, which is not usable by players

  default_detainer_hero_card = upsert_hero_card(
    'Xedrai',
    flavor_text: '<p>The default <b>Detainer</b> Hero</p>'
  )
  PlayerClassCard.find_or_create_by(player_class: detainer_class, card: default_detainer_hero_card)

  default_magus_hero_card = upsert_hero_card(
    'Santo',
    flavor_text: '<p>The default <b>Magus</b> Hero</p>'
  )
  PlayerClassCard.find_or_create_by(player_class: magus_class, card: default_magus_hero_card)

  default_sage_hero_card = upsert_hero_card(
    'Dianaria',
    flavor_text: '<p>The default <b>Sage</b> Hero</p>'
  )
  PlayerClassCard.find_or_create_by(player_class: sage_class, card: default_sage_hero_card)

  default_trapper_hero_card = upsert_hero_card(
    'Crianh',
    flavor_text: '<p>The default <b>Trapper</b> Hero</p>'
  )
  PlayerClassCard.find_or_create_by(player_class: trapper_class, card: default_trapper_hero_card)

  default_warden_hero_card = upsert_hero_card(
    'Gorioh',
    flavor_text: '<p>The default <b>Warden</b> Hero</p>'
  )
  PlayerClassCard.find_or_create_by(player_class: warden_class, card: default_warden_hero_card)

  attach_card_image(default_detainer_hero_card, 'Xedrai-Placeholder.png')
  attach_card_image(default_magus_hero_card, 'Santo-Placeholder.png')
  attach_card_image(default_sage_hero_card, 'Dianaria-Placeholder.png')
  attach_card_image(default_trapper_hero_card, 'Crianh-Placeholder.png')
  attach_card_image(default_warden_hero_card, 'Gorioh-Placeholder.png')
end

def self.upsert_hero_card(name, flavor_text:)
  card = HeroCard.find_by(name: name) || HeroCard.new(name: name)

  card.assign_attributes(
    card_text: '',
    armor: 0,
    cost: 0,
    rarity: 'Legendary',
    expansion_id: 1,
    flavor_text: flavor_text,
    excluded_from_deckbuilding: true
  )
  card.save!

  card
end

  def self.create_new_classes
    # end I make more classes, they'll go here (but that's for later)
  end

  def self.attach_card_image(card, filename)
    path = PLAYER_CLASS_IMAGE_PATH.join(filename)

    raise "Missing seed image: #{path}" unless File.exist?(path)

    puts "|--[Attaching from filepath: #{path}] for card: #{card.name}"

    seed_checksum = Base64.strict_encode64(Digest::MD5.file(path).digest)

    # Always work with a fresh record so we don't fight a stale attachment
    card.reload

    if card.card_art_img.attached?
      current_checksum = card.card_art_img.blob.checksum

      if current_checksum == seed_checksum
        puts "|--------> Checksum for #{card.name} matches, skipping..."
        return
      end

      puts "|--------> Checksum mismatch for #{card.name}, purging old image..."
      card.card_art_img.purge
      card.reload
    end

    # Open the file in a block so the handle is guaranteed to close
    File.open(path, 'rb') do |file|
      card.card_art_img.attach(
        io: file,
        filename:,
        content_type: 'image/png',
        identify: false # skip image analysis if you don't need it
      )
    end

    # Force a reload and verify the attachment actually stuck
    card.reload

    unless card.card_art_img.attached?
      raise "Attachment failed for #{card.name} – card_art_img is still missing after attach"
    end

    unless card.card_art_img.blob.checksum == seed_checksum
      raise "Checksum mismatch after attach for #{card.name} " \
            "(expected #{seed_checksum}, got #{card.card_art_img.blob.checksum})"
    end

    puts "|--------> Successfully attached #{filename} to #{card.name}"
  rescue StandardError => e
    puts "[Failed to attach #{filename} to #{card.name}]: #{e.class} - #{e.message}"
    raise e
  end

  private_class_method :attach_card_image
end
