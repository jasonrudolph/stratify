Stratify::Application.routes.draw do
  resources :activities
  
  resources :collectors do
    post 'run', :on => :member
  end

  root :to => "activities#index"
end
