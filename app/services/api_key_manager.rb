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
  def self.validate_api_key(api_key, stored_checksum)
    computed_checksum = generate_checksum(api_key)

      # Compare the computed checksum with the stored checksum
    computed_checksum == stored_checksum
  end



  def self.render_api_key(checksum_value)
    checksum_value.gsub(PREFIX, '').gsub(POSTFIX, '')
  end



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
end
