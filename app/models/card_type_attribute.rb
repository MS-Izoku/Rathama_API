class CardTypeAttribute < ApplicationRecord
    validates :type, presence: true

    def validate_type
        errors.add(:type, "Cannot be ") if !type
    end
end
