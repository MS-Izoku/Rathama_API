class CardTypeAttributesController < ApplicationController

# region: Tribes

  # return a list of all Tribes
  def tribes
    render json: Tribe.all
  end


  # return a list of all Tribe Names
  def tribe_names
    render json: Tribe.all.select(:name)
  end


  def tribes_alphebetically
    render json: Tribe.all.order(name: :asc).select(:name)
  end


  def tribes_reverse_alphabetically
    render json: Tribe.all.order(name: :desc).select(:name)
  end


  def create_tribe
    create_card_type_attribute(tribe_params, "Tribe")
  end
# endregion


# region: Spell Schools

  # return a list of all Spell Schools
  def spell_schools
    render json: SpellSchool.all
  end
  
  # return a list of all Spell School Names
  def spell_school_names
    render json: SpellSchool.all.select(:name)
  end


  def spell_schools_alphebetically
    render json: SpellSchool.all.order(name: :asc).select(:name)
  end


  def spell_schools_reverse_alphabetically
    render json: SpellSchool.all.order(name: :desc).select(:name)
  end

  def create_spell_school
    create_card_type_attribute(spell_school_params, "SpellSchool")
  end

#endregion


# region: Attribute Management

  # region: Addition
  def add_tribe_to_fiend
  end

  def add_spell_school_to_spell
  end


  def add_spell_school_to_trap
  end
  # endregion


  # region: removal
  def remove_tribe_from_fiend
  end


  def remove_spell_school_from_spell
  end


  def remove_spell_school_from_trap
  end

  # endregion

# endregion



private
# region: Strong Params

  def tribe_params
    params.require(:tribe).permit(:name, :description)
  end

  def spell_school_params
    params.require(:spell_school).permit(:name, :description)
  end

# endregion

  def create_card_type_attribute(params, attribute_type = "Tribe")
    if attribute_type == "Tribe"
      existing_tribe = Tribe.find_by(name: params[:name])
      if !existing_tribe
        existing_tribe = Tribe.new(params) 
        render json: existing_tribe if existing_tribe.save
      else
        render json: { message: "Tribe with that name already exists" }
      end

    elsif attribute_type == "SpellSchool"
      existing_school = SpellSchool.find_by(name: params[:name])
      if !existing_school
        existing_school = SpellSchool.new(params)
        render json: existing_school if existing_school.save
      end
    end
  end

end
