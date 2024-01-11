Rails.application.routes.draw do
  get 'decks/index'
  get 'decks/show'
  get 'decks/create'
  get 'decks/update'
  get 'decks/destroy'
#region CardTypeAttributes (Tribes and SpellSchools)

  # region Tribes
    get 'card_type_attributes/tribes', to: 'card_type_attributes#tribes'
    get 'tribes', to: 'card_type_attributes#tribes'

    get 'card_type_attributes/tribe_names', to: 'card_type_attributes#tribe_names'
    get 'tribes/names', to: 'card_type_attributes#tribe_names'
  # endregion


  # region Spell Schools
    get 'card_type_attributes/spell_schools', to: 'card_type_attributes#spell_schools'
    get 'card_type_attributes/spell_school_names', to: 'card_type_attributes#spell_school_names'

    get 'spell_schools', to: 'card_type_attributes#spell_schools'
    get 'spell_schools/names', to: 'card_attributes#spell_school_names'
  # endregion

# endregion



end
