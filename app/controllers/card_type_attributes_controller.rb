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
# endregion


# region: Spell Schools
  # return a list of all Spell Schools
  def spell_schools
    render json: SpellSchool.all
  end
  
  # return a list of all Spell School Names
  def spell_schools
    render json: SpellSchool.all.select(:name)
  end
#endregion


end
