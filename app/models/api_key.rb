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

    def validate_permission(permission)
        #self.permissions.include?(permission)
        true
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


    def all_permissions
        %w[
            api_update              # can update the API Version
            client_update           # can update the Client Version
            take_notes              # can create release-notes
            update_note_params      # can update release-notes
            destroy_notes           # can destroy release-notes

            create_card             # can create cards
            update_card             # can update cards
            destroy_card            # can destroy cards

            create_spell_school     # can create Spell Schools
            update_spell_school     # can update Spell Schools
            destroy_spell_school    # can destroy Spell Schools

            create_tribe            # can create Tribes
            update_tribe            # can update Tribes
            destroy_tribe           # can destroy Tribes

            create_keywords         # can create keywords
            update_keywords         # can update keywords
            destroy_keywords        # can destroy keywords

            create_player_classes   # can create player classes
            update_player_classes   # can update player classes
            destroy_player_classes  # can destroy player classes

            create_scales           # can create scale powers
            update_scales           # can update scale powers
            destroy_scales          # can destroy scale powers

            create_expansion        # can create expansions
            update_expansion        # can update expansions
            destroy_expansion       # can delete expansions

        ]
    end
end
