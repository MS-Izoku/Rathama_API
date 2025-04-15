# frozen_string_literal: true

class ExpansionsController < ApplicationController
  def index
    @expansions = Expansion.all.to_a

    if Rails.cache.exist?('expansions')
      @expansions = Rails.cache.read('expansions')
    else
      @expansions = Expansion.all.to_a
      Rails.cache.write('expansions', @expansions, expires_in: 12.hours)
    end
    render json: ExpansionSerializer.many(@expansions)
  end

  def show
    @expansion = Expansion.find_by(id: params[:id])
    return render json: { error: 'Expansion not found' }, status: :not_found unless @expansion

    key = "expansion_#{@expansion.id}"

    if Rails.cache.exist?(key)
      @expansion = Rails.cache.read(key)
    else
      Rails.cache.write(key, @expansion, expires_in: 12.hours)
    end

    render json: ExpansionSerializer.one(@expansion)
  end

  def create
    @expansion = Expansion.new(expansion_params)
    @expansion.expected_release_date = expansion_params.release_date
    if @expansion.save!
      render json: @expansion
    else
      render json: { message: 'Failed to save Expansion', errors: @expansion.errors.full_messages }
    end
  end

  def update; end

  def destroy; end

  def expansion_creator_data
    groups = ExpansionGroup.all.each_with_object({}) do |group, hash|
      hash[group.year] = {
        id: group.id,
        name: group.year,
        iconUrl: group.icon_url,
        expansions: ExpansionSerializer.many(group.expansions),
        expansionCount: group.expansions.count
      }
    end

    render json: {
      expansionGroups: groups
    }
  end

  private

  def expansion_params
    params.require(:expansion).permit(
      :name,
      :description,
      :tagline,
      :expansion_group_id,
      :release_date
    )
  end
end
