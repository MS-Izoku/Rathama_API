# frozen_string_literal: true

class CardMechanic < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validates :description, presence: true
  # validate :validate_args_format

  before_save :format_args, :create_mechanic_string

  # Define available enums globally (can be expanded later)
  ENUMS = {
    'effectConditions' => {
      'hasPlayedCardsOfType' => ['CardType' , 'Integer'],
      'fiendsHaveDied' => "Integer",
      'monumentsHaveDied' => "Integer",
      'weaponsDestroyed' => "Integer",
      'rookShiftCount' => 'Integer',
      'hasRooks' => 'Boolean',
      'hasNexus' => 'Boolean',
      'hasLinkSet' => 'Boolean',
      'hasFullLink' => 'Boolean'
    },
    'targetTypes' => %w[
      SingleTarget SingleNonPlayerTarget SingleEnemy SingleAlly
      AllEnemy AllAllies All Opponent
      Player Self Any
    ].freeze,
    'findSelectionTypes' => %w[
      FromDeck FromOpponentsDeck FromClass FromClassAndNeutral
      FromNeutral FromDetainer FromMagus FromSage FromTrapper FromWarden
    ].freeze,
    'subEffect': 'TBD',
    'heroLifecycle' => %w[Root Dawn Call AttackDeclared TargetedForAttack TargetedBySpell PostAttackStep Overkill Rale
                          Cusp].freeze,
    'fiendLifecycle' => %w[Root Dawn Call Nexus Rook Link AttackDeclared TargetedForAttack TargetedBySpell DamageStep PostAttackStep Overkill
                           Rale Cusp].freeze,
    'monumentLifecycle' => %w[Root Dawn Call Nexus Rook Link OnMonumentActivate Overkill Rale OnResolve].freeze,
    'spellLifecycle' => %w[Root OnSpellActivate Overkill OnResolve].freeze,
    'trapLifecycle' => %w[Root OnTrapActivate Overkill OnResolve].freeze,
    'weaponLifecycle' => %w[Root Dawn Call AttackDeclared DamageStep PostAttackStep Overkill Rale Cusp].freeze
  }.freeze

  # region: Enum Exposure
  def self.target_types
    ENUMS['targetType']
  end

  def self.all_lifecycle_stages
    [
      hero_lifecycle_stages,
      fiend_lifecycle_stages,
      monument_lifecycle_stages,
      spell_lifecycle_stages,
      trap_lifecycle_stages,
      weapon_lifecycle_stages
    ].flatten.uniq
  end

  def self.hero_lifecycle_stages
    # Root Dawn Call AttackDeclared TargetedForAttack PostAttackStep Rale Cusp
    ENUMS['heroLifecycle']
  end

  def self.fiend_lifecycle_stages
    # Root Dawn Call AttackDeclared TargetedForAttack DamageStep PostAttackStep Rale Cusp
    ENUMS['fiendLifecycle']
  end

  def self.monument_lifecycle_stages
    # Root Dawn Call OnMonumentActivate Rale OnResolve
    ENUMS['monumentLifecycle']
  end

  def self.spell_lifecycle_stages
    # Root OnSpellActivate OnResolve
    ENUMS['spellLifecycle']
  end

  def self.trap_lifecycle_stages
    # Root OnTrapActivate OnResolve
    ENUMS['trapLifecycle']
  end

  def self.weapon_lifecycle_stages
    # Root Dawn Call AttackDeclared DamageStep PostAttackStep Rale Cusp
    ENUMS['weaponLifecycle']
  end

  # endregion

  private

  # Parses the args string into a hash: "damage:integer, targetType:someEnum" → { damage: "integer", targetType: "someEnum" }
  def parsed_args
    return {} if args.blank?

    args.split(',').map(&:strip).map { |pair| pair.split(':') }.to_h.symbolize_keys
  end

  # Ensures args follow the correct format (e.g., "damage:integer, targetType:someEnum")
  def validate_args_format
    return if args.blank?

    unless args.match?(/^(\w+:\w+(,\s?\w+:\w+)*)$/)
      errors.add(:args, "must follow key:value format (e.g., 'damage:integer, targetType:someEnum')")
      return
    end

    validate_args_types(parsed_args)
  end

  # Checks if each argument matches its expected type
  def validate_args_types(parsed_args)
    return if parsed_args.empty?

    parsed_args.each do |key, expected_type|
      errors.add(:args, "#{key} must be of type #{expected_type}") unless valid_type?(key, expected_type)
    end
  end

  # Determines if the argument type is valid
  def valid_type?(key, expected_type)
    case expected_type
    when 'integer', 'string'
      true # Integers and strings are valid base types
    else
      ENUMS[key]&.include?(expected_type) # Check if it's a valid enum type for the given key
    end
  end

  def create_mechanic_string
    # Format the mechanic name and ensure there is no whitespace (which is fine in declaration)
    self.name = name.titlecase.delete(' ')
    self.args = args.delete(' ') if args.present?
  end

  def format_args
    self.args = args.delete(' ') if args.present?
  end
end
