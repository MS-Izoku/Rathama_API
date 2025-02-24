# frozen_string_literal: true

class SeedPlayerClasses
  def self.seed
    create_initial_classes
    create_new_classes
  end

  private
  def self.create_initial_classes
    neutral = PlayerClass.find_or_create_by(
      name: 'Neutral',
      description: 'Cards which can be used without a class restriction'
    )

    neutral.id = 0
    neutral.save!

    PlayerClass.find_or_create_by(
      name: 'Detainer',
      description: ''
    )

    PlayerClass.find_or_create_by(
      name: 'Magus',
      description: ''
    )

    PlayerClass.find_or_create_by(
      name: 'Sage',
      description: ''
    )

    PlayerClass.find_or_create_by(
      name: 'Trapper',
      description: ''
    )

    PlayerClass.find_or_create_by(
      name: 'Warden',
      description: ''
    )
  end

  def self.create_new_classes
  end
end
