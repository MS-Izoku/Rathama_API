class QuestSerializer < Oj::Serializer
    attributes :name, :description, :quest_type, :expiration, :can_expire
end