class CardMechanic < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validates :description, presence: true
  validate :validate_args_format

  before_save :format_args, :create_mechanic_string

  # Define available enums globally (can be expanded later)
  ENUMS = {
    'targetType' => %w[SingleTarget SingleNonPlayerTarget SingleEnemy SingleAlly AllEnemy AllAllies All Opponent Player Self Any]
  }.freeze

  # Parses the args string into a hash: "damage:integer, targetType:someEnum" → { damage: "integer", targetType: "someEnum" }
  def parsed_args
    return {} if args.blank?

    args.split(',').map(&:strip).map { |pair| pair.split(':') }.to_h.symbolize_keys
  end

  private

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
      unless valid_type?(key, expected_type)
        errors.add(:args, "#{key} must be of type #{expected_type}")
      end
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
