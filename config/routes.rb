Stratify::Application.routes.draw do
  resources :activities
  
  resources :collectors

  root :to => "activities#index"
end
