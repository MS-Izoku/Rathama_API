# frozen_string_literal: true

class ScalePowerMicroSerializer < Oj::Serializer
  object_as :scale_power

  attributes :id, :name, :description, :art_url, :cost

  attribute :art_url do
    scale_power.art_url # uses the helper we just added
  end
end
