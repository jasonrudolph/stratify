Stratify::Application.routes.draw do
  resources :activities

  root :to => "activities#index"
end
