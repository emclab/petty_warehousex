PettyWarehousex::Engine.routes.draw do

  resources :items do
    collection do
      get :search
      get :search_results
      get :autocomplete
    end
  end
  
  root :to => 'items#index'
end
