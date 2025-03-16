# frozen_string_literal: true

Rails.application.routes.draw do
# region: Card Creator
  get 'cards/creator-info', to: 'cards#card_creator_inputs'
# endregion



# region Cards
  get 'cards/fiends', to: 'cards#fiends'
  get 'cards/heroes', to: 'cards#heroes'
  get 'cards/monuments', to: 'cards#monuments'
  get 'cards/spells', to: 'cards#spells'
  get 'cards/traps', to: 'cards#traps'
  get 'cards/weapons', to: 'cards#weapons'

  post 'cards', to: 'cards#create'

  patch 'cards', to: 'cards#update'

  delete 'cards', to: 'cards#destroy'

  get 'cards/expansions/:expansion_id/cards', to: 'cards#cards_from_expansion'
  get 'cards/expansions/:expansion_id/fiends', to: 'cards#fiends_from_expansion'
  get 'cards/expansions/:expansion_id/heroes', to: 'cards#heroes_from_expansion'
  get 'cards/expansions/:expansion_id/monuments', to: 'cards#monuments_from_expansion'
  get 'cards/expansions/:expansion_id/spells', to: 'cards#spells_from_expansion'
  get 'cards/expansions/:expansion_id/traps', to: 'cards#traps_from_expansion'
  get 'cards/expansions/:expansion_id/weapons', to: 'cards#weapons_from_expansion'


  resources :cards, only: %i[index show create update destroy] do
    put 'cards/change_image', to: 'cards#change_image'
    post 'search', to: 'cards#search' # using POST since it can have a request body
  end
# endregion

# region Expansions
  get 'expansions', to: 'expansions#index'
  get 'expansions/:id', to: 'expansions#show'
# endregion

  post 'login', to: 'authentication#login'

  get 'users/profile'
  get 'users/grant_api_key', to: 'users#grant_api_key'
  get 'users/rotate_api_key', to: 'users#rotate_api_key'

  post 'users/', to: 'users#create'
  delete 'users/', to: 'users#destroy'

  get 'decks', to: 'decks#index'
  get 'decks/:id', to: 'decks#show'
  post 'decks/', to: 'decks#create'
  patch 'decks/:id', to: 'decks#update'
  delete 'decks/:id', to: 'decks#destroy'

# region CardTypeAttributes (Tribes and SpellSchools)

  # region Tribes
  get 'card-type-attributes/tribes', to: 'card_type_attributes#tribes'
  get 'tribes', to: 'card_type_attributes#tribes'

  get 'card-type-attributes/tribe_names', to: 'card_type_attributes#tribe_names'
  get 'tribes/names', to: 'card_type_attributes#tribe_names'
  # endregion

  # region Spell Schools
  get 'card-type_attributes/spell_schools', to: 'card_type_attributes#spell_schools'
  get 'card-type_attributes/spell_school_names', to: 'card_type_attributes#spell_school_names'

  get 'spell-schools', to: 'card_type_attributes#spell_schools'
  get 'spell-schools/names', to: 'card_attributes#spell_school_names'
  # endregion

# endregion


# region Quests

  get 'quests/show-player-quests', to: 'quests#show_player_quests'
  post 'quests/generate-weekly', to: 'quests#give_player_weekly_quests'
  post 'quests/generate-daily', to: 'quests#give_player_daily_quests'
  post 'quests/reroll', to: 'quests#reroll_player_quest'
  patch 'quests/progress', to: 'quests#add_quest_progress'

# endregion


# region Card Rendering
# endregion


  post '/login', to: 'users#login'
  get '/login', to: 'users#authenticate_token'

  namespace :cocktails do
    get ''
  end
end
