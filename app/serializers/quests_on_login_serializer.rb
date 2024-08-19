class QuestsOnLoginSerializer < Oj::Serializer
    # Define attributes from PlayerQuest
    attributes :id, :current_completion_value, :target_completion_value, :expiration_date
  
    # Define attributes from associated Quest
    attributes :name, :description, :quest_expiration, :can_expire
  
    attribute
    def name
      @object.quest.name
    end
  
    attribute
    def description
      @object.quest.description
    end
  
    attribute
    def quest_expiration
      @object.quest.expiration
    end
  
    attribute
    def can_expire
      @object.quest.can_expire
    end

    attribute
    def player_quest_id
        @object.id
    end
end