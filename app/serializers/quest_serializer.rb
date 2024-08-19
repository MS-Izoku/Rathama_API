class QuestSerializer < Oj::Serializer
    attributes :name, :description, :expiration, :can_expire
end