Stratify::Application.routes.draw do
  resources :activities
  
  resources :collectors do
    post 'run', :on => :member
  end

  get "/graphs" => redirect("/graphs/punch_card"), :as => :graphs
  get 'graphs/:action' => 'graphs#:action'
  
  root :to => "activities#index"
end
