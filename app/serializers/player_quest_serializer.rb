class PlayerQuestSerializer < Oj::Serializer

    attributes :current_completion_value, :target_completion_value, :expiration_date, :is_completed
    has_one :quest, serializer: QuestSerializer

end