Rails.application.routes.draw do
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

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
