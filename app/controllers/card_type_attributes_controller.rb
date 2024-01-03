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

#endregion


end
