require 'digest'
require 'base64'

class ApiKeyManager
  PREFIX = '[]==ZGpGemFFRnJRREZ6'
  POSTFIX = 'VjBBM1kyZ3hUbWM9==[]'

  # generate a random key using base64
  def self.generate_key
    SecureRandom.base64.tr('+/=', 'Qrt')
  end


  # a checksum for a valid decoded API Key
  def self.generate_checksum(key)
    base = Digest::SHA256.hexdigest(key)
    "#{PREFIX}#{base}#{POSTFIX}"
  end


  # validate the existing api key against the checksum of that key
  # returns true if the submitted API Key is the same as the generated Checksum
  def self.validate_api_key(api_key, stored_checksum)
    computed_checksum = generate_checksum(api_key)

      # Compare the computed checksum with the stored checksum
    computed_checksum == stored_checksum
  end



  # turns a checksum into the decoded API-Key Digest (not the actual API Key)
  def self.render_api_key(checksum_value)
    #puts ">> Checksum: #{checksum_value}"
    res = checksum_value.gsub(PREFIX, '')
    #puts ">> Result on Gsub (prefix::#{PREFIX}): #{res}"
    res = res.gsub(POSTFIX,  "")
    #puts ">> Result on Gsub (postfix::#{POSTFIX}): #{res}"
    res
  end


  # an example implementation used to generate an api key digest
  def self.example
    key = ApiKeyManager.generate_key
    puts "Generated API Key (#generate_key) => #{key}"

    checksum = generate_checksum(key)
    puts "Checksum from Key (#generate_checksum) => #{checksum}"

    puts "Key to Checksum match? (#validate_api_key) => #{validate_api_key(key, checksum)}"

    decoded = render_api_key(checksum)
    puts "Decoded Key from Checksum (#render_api_key) => #{decoded}"

    decoded
  end


  # generate an API Key that is not in use
  def self.generate_api_key(attempt = 0)
    puts "Making attempt: #{attempt}"
     if attempt > 5
        puts "Max number of API request attempts made"
        return nil
     end

    key = ApiKeyManager.generate_key
    checksum = generate_checksum(key)

    validated = validate_api_key(key, checksum) && User.find_by(api_key_digest: checksum).nil?

    if validated
      { key:, checksum: , validated: }
    else
      puts "Invalid Key Generated"
      generate_api_key(attempt + 1)
    end
  end


# region Permission Management
  # all possible permissions available to any API Key
  def self.all_permissions
    [
        # Card Permissions
        "create_cards",
        "update_cards",
        "delete_cards",


        # Expansions
        "create_expansions",
        "update_expansions",
        "delete_expansions",

        # Player Classes
        "create_player_classes",
        "update_player_classes",
        "destroy_player_classes",

        # Tribes and Spell Schools
        "create_tribes",
        "create_spell_schools",
        "update_tribes",
        "update_spell_schools",
        "delete_tribes",
        "delete_spell_schools",

        # Scale Powers
        "create_scale_powers",
        "update_scale_powers",
        "delete_scale_powers",

        # Keywords
        "create_keywords",
        "update_keywords",
        "delete_keywords",

        # API Key
        "create_key",
        "update_key",
        "delete_key",
        "activate_key",
        "deactivate_key",
        "add_permissions",
        "remove_permissions",
    ]
  end

  def self.authorize(permission)
    unless has_permission?(permission)
      errors.add(:base, 'Unauthorized')
      throw(:abort)
    end
  end

# endregion

end
