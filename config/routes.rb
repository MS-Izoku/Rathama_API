Rails.application.routes.draw do
  resources :cards, only: %i[index show create update destroy] do
    put 'cards/change_image', to: 'cards#change_image'
    post 'search', to: 'cards#search' # using POST since it can have a request body
    # put 'cards/add_variant_image', to: ""
  end


  post 'login', to: 'authentication#login'

  get 'users/profile'
  get 'users/grant_api_key', to: 'users#grant_api_key'
  get 'users/rotate_api_key', to: 'users#rotate_api_key'

  post 'users/', to: 'users#create'
  delete 'users/', to: "users#destroy"

  get 'decks/index', to: 'decks#index'
  get 'decks/:id', to: 'decks#show'
  post 'decks/', to: 'decks#create'
  patch 'decks/', to: 'decks#update'
  delete 'decks/:id', to: 'decks#destroy'

# region CardTypeAttributes (Tribes and SpellSchools)

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

  post '/login', to: 'users#login'
  get '/login', to: 'users#authenticate_token'
end
