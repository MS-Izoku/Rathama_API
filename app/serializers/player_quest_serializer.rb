class PlayerQuestSerializer < Oj::Serializer

    attributes :current_completion_value, :target_completion_value, :expiration_date
    has_one :quest, serializer: QuestSerializer

end