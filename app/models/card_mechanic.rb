# frozen_string_literal: true

class CardMechanic < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validates :description, presence: true
  validate :validate_args_format

  before_save :format_args, :create_mechanic_string

  # Define available enums globally (can be expanded later)
  ENUMS = {
    'target_type' => %w[
      SingleTarget SingleNonPlayerTarget SingleEnemy SingleAlly
      AllEnemy AllAllies All Opponent
      Player Self Any
    ].freeze,
    'lifecycle' => %w[
      Root Dawn Call AttackDeclared
      Cusp OnResolve Rale OnDamaged
      TargetedForAttack DamageStep PostAttackStep OnMonumentActivate
      OnSpellActivate OnTrapActivate
    ].freeze,
    'hero_lifecycle' => %w[Root Dawn Call AttackDeclared TargetedForAttack PostAttackStep Rale Cusp].freeze,
    'fiend_lifecycle' => %w[Root Dawn Call AttackDeclared TargetedForAttack DamageStep PostAttackStep Rale Cusp].freeze,
    'monument_lifecycle' => %w[Root Dawn Call OnMonumentActivate Rale OnResolve].freeze,
    'spell_lifecycle' => %w[Root OnSpellActivate OnResolve].freeze,
    'trap_lifecycle' => %w[Root OnTrapActivate OnResolve].freeze,
    'weapon_lifecycle' => %w[Root Dawn Call AttackDeclared DamageStep PostAttackStep Rale Cusp].freeze
  }.freeze

  # region: Enum Exposure
  def self.target_types
    ENUMS['target_type']
  end

  def self.all_lifecycle_stages
    ENUMS['lifecycle']
  end

  def self.hero_lifecycle_stages
    # Root Dawn Call AttackDeclared TargetedForAttack PostAttackStep Rale Cusp
    ENUMS['hero_lifecycle']
  end

  def self.fiend_lifecycle_stages
    # Root Dawn Call AttackDeclared TargetedForAttack DamageStep PostAttackStep Rale Cusp
    ENUMS['fiend_lifecycle']
  end

  def self.monument_lifecycle_stages
    # Root Dawn Call OnMonumentActivate Rale OnResolve
    ENUMS['monument_lifecycle']
  end

  def self.spell_lifecycle_stages
    # Root OnSpellActivate OnResolve
    ENUMS['spell_lifecycle']
  end

  def self.trap_lifecycle_stages
    # Root OnTrapActivate OnResolve
    ENUMS['trap_lifecycle']
  end

  def self.weapon_lifecycle_stages
    # Root Dawn Call AttackDeclared DamageStep PostAttackStep Rale Cusp
    ENUMS['weapon_lifecycle']
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
