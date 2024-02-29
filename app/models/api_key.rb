class ApiKey < ApplicationRecord
    belongs_to :owner, polymorphic: true

    # issue an API key to an existing user
    # return the raw key to render (to give to the user)
    def issue_to_user(user_id)
        user = User.find_by(id: user_id)
        return if user_id.nil? || user.nil?
        
        api_key_data = ApiKeyManager.generate_api_key
        puts api_key_data

        raw_key = ApiKeyManager.generate_key
        self.api_key_digest = ApiKeyManager.generate_checksum(raw_key)
        self.owner = user
        save

        raw_key
    end

    # validate the API key using the stored key-digest on this model, checking against the input
    def authorize(input_api_key)
        ApiKeyManager.validate_api_key(input_api_key, api_key_digest)
    end

    # deactivate the API key without destroying it
    def deactivate
        self.is_active = false
    end

    # activate an API Key which may have been inactive
    def activate
        self.is_active = true
    end


# region: API Key Permissions
    # does this key have a specific permission?
    def has_permission?(permission)
        # change the add_permissions_to_api_keys migration, postgres array implementation is commented out due to Sqlite limitations
        # permissions.include?(permission.to_s) # use only when using postgres
        true
    end

    
# endregion
end
