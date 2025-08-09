# frozen_string_literal: true

class ExpansionSerializer < Oj::Serializer
  attributes :id, :name, :description, :tagline, :expansion_group_id, :release_date, :released, :on_time
end
