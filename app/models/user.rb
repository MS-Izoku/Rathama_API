class User < ApplicationRecord
  has_secure_password
  has_many :api_keys, as: :owner
  has_many :decks, foreign_key: 'owner_id'

  has_many :cards

    # the general  "Collection" of a user is their owned cards
  def collection
    cards
  end

  def deactivate_api_keys
    api_key_model = ApiKey.where(owner_id: id)

    save unless api_key_model.nil?
    nil
  end

    # validates an input passwords format.  Used before hashing the password using BCrypt
  def self.validate_password_format(raw_password)
    errors = []

      # Minimum of 8 characters
    errors << 'Password must be at least 8 characters long.' if raw_password.length < 8

      # Includes at least one uppercase letter
    errors << 'Password must include at least one uppercase letter.' unless raw_password =~ /[A-Z]/

      # Includes at least one lowercase letter
    errors << 'Password must include at least one lowercase letter.' unless raw_password =~ /[a-z]/

      # Includes at least one digit
    errors << 'Password must include at least one digit.' unless raw_password =~ /\d/

      # Includes at least one special character
    errors << 'Password must include at least one special character.' unless raw_password =~ /[!@#$%^&*()-=+_]/

      # Does not contain spaces or slashes
    errors << 'Password cannot contain spaces or slashes.' if raw_password =~ %r{[\s/]}

      # If there are errors, return the array of errors
      # Otherwise, return the raw_password
    errors.empty? ? raw_password : errors
  end
end
