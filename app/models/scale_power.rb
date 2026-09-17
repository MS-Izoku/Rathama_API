# frozen_string_literal: true

# Once-per-turn use abilities, often associated with HeroCards
class ScalePower < ApplicationRecord
  # region: relationships
  belongs_to :player_class
  belongs_to :hero_card, optional: true

  has_one_attached :art
  # endregion

  # region: Validations
  validates :name, uniqueness: true
  validates :description, presence: true
  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # endregion

  def self.scale_power_positions
    %w[Left Right]
  end

  def validate_scale_power_position
    # rubocop:disable Style/GuardClause
    unless ScalePower.scale_power_positions.include?(position)
      errors.add(
        :position,
        "must be one of: #{ScalePower.scale_power_positions.join(', ')}"
      )
    end
    # rubocop:enable Style/GuardClause
  end

  def art_url
    return nil unless art.attached?

    ActiveStorage::Current.url_options ||= ActiveStorageConfiguration.env_config
    art.url
  end
end
