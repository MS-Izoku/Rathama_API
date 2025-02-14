# frozen_string_literal: true

class CardTypeAttributesController < ApplicationController
# region: Tribes

  # return a list of all Tribes
  def tribes
    @tribes = Tribe.all
    render json: CardTypeAttributeSerializer.many(@tribes)
  end

  # return a list of all Tribe Names
  def tribe_names
    render json: Tribe.all.select(:name)
  end

  def tribes_alphebetically
    @tribes = Tribe.all.order(name: :asc)
    render json: CardTypeAttributeSerializer.many(@tribes)
  end

  def tribes_reverse_alphabetically
    @tribes = Tribe.all.order(name: :desc)
    render json: CardTypeAttributeSerializer.many(@tribes)
  end

  def create_tribe
    create_card_type_attribute(tribe_params, 'Tribe')
  end
# endregion

# region: Spell Schools

  # return a list of all Spell Schools
  def spell_schools
    @spell_schools = SpellSchool.all
    render json: CardTypeAttributeSerializer.many(@spell_schools)
  end

  # return a list of all Spell School Names
  def spell_school_names
    @spell_schools = SpellSchool.all
    render json: CardTypeAttributeSerializer.many(@tribes)
  end

  def spell_schools_alphebetically
    @spell_schools = SpellSchool.all.order(name: :asc)
    render json: CardTypeAttributeSerializer.many(@spell_schools)
  end

  def spell_schools_reverse_alphabetically
    @spell_schools = SpellSchool.all.order(name: :desc)
    render json: CardTypeAttributeSerializer.many(@spell_schools)
  end

  def create_spell_school
    create_card_type_attribute(spell_school_params, 'SpellSchool')
  end

# region Spell School CRUD
  def create_spell_school
    spell_school = SpellSchool.find_by(spell_school_params[:name])

    spell_school ||= SpellSchool.create(spell_school_params)

    render json: spell_school
  end

  def update_spell_school
    spell_school = SpellSchool.find_by(spell_school_params[:name])

    if !spell_school
      render json: { error: { message: "Spell School with the name [#{spell_school_params[:name]}] already exists" } }
    else
      spell_school.update(spell_school_params)
      render json: spell_school
    end
  end

  def destroy_spell_school
    spell_school = SpellSchool.find_by(spell_school_params[:name])

    if !spell_school
      render json: { error: { message: "Spell School with the name [#{spell_school_params[:name]}] does not exist" } }
    else
      spell_school.destroy
      render json: spell_school
    end
  end
# endregion

# endregion

# region: Attribute Management

# region: Addition
  def add_tribe_to_fiend; end

  def add_spell_school_to_spell; end

  def add_spell_school_to_trap; end

  def create_tribe; end
# endregion

# region: removal
  def remove_tribe_from_fiend; end

  def remove_spell_school_from_spell; end

  def remove_spell_school_from_trap; end

# endregion

# endregion

  def create_card_type_attribute
    if attribute_type == 'Tribe'
      existing_tribe = Tribe.find_by(name: params[:name])
      if !existing_tribe
        existing_tribe = Tribe.new(params)
        render json: existing_tribe if existing_tribe.save
      else
        render json: { message: 'Tribe with that name already exists' }
      end

    elsif attribute_type == 'SpellSchool'
      existing_school = SpellSchool.find_by(name: params[:name])
      unless existing_school
        existing_school = SpellSchool.new(params)
        render json: existing_school if existing_school.save
      end
    end
  end

  private

# region: Strong Params

  def tribe_params
    params.require(:tribe).permit(:name, :description)
  end

  def spell_school_params
    params.require(:spell_school).permit(:name, :description)
  end

  def verify_attribute_as_tribe(attribute)
    attribute.type == 'Tribe'
  end

  def verify_attribute_as_spell_school(attribute)
    attribute.type == 'SpellSchool'
  end

# endregion
end
