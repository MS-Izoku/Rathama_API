# frozen_string_literal: true

class ExpansionSerializer < Oj::Serializer
  attributes :id, :name, :description, :expansion_group_id
end
