class ScalePowersController < ApplicationController
  def scale_power_creator_portal
    key = 'scale_power_creator_portal'

    if Rails.cache.exist?(key)
      @portal_data = Rails.cache.read(key)
    else
      @portal_data = { heroes: HeroIndexSerializer.many(HeroCard.all) }.as_json
      Rails.cache.write(key, @portal_data, expires_in: 12.hours)
    end

    render json: @portal_data
  end
end