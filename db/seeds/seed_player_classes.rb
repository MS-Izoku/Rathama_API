# frozen_string_literal: true

class SeedPlayerClasses
  NEUTRAL_CLASS_NAME = "Neutral".freezegit

  def self.seed
    create_initial_classes
    create_new_classes
  end

  private
  def self.create_initial_classes
    # setting Ids will be done manually here to prevent any weird asscociations
    unless (PlayerClass.find_by(name: NEUTRAL_CLASS_NAME))
      neutral = PlayerClass.new(
        name: NEUTRAL_CLASS_NAME,
        description: 'Cards which can be used without a class restriction'
      )
      neutral.id = 0
      neutral.save!
    end

    PlayerClass.find_or_create_by(
      id: 1,
      name: 'Detainer',
      description: ''
    )

    PlayerClass.find_or_create_by(
      id: 2,
      name: 'Magus',
      description: ''
    )

    PlayerClass.find_or_create_by(
      id: 3,
      name: 'Sage',
      description: ''
    )

    PlayerClass.find_or_create_by(
      id: 4,
      name: 'Trapper',
      description: ''
    )

    PlayerClass.find_or_create_by(
      id: 5,
      name: 'Warden',
      description: ''
    )
  end

  def self.create_new_classes
  end
end
