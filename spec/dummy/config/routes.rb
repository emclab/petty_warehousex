Rails.application.routes.draw do

  mount PettyWarehousex::Engine => "/petty_warehousex"
  mount Authentify::Engine => "/authentify"
  mount Commonx::Engine => "/commonx"
  mount Supplierx::Engine => '/supplier'
  mount Searchx::Engine => '/searchx'
  mount ExtConstructionProjectx::Engine => '/project'
  mount Kustomerx::Engine => '/customer'
  mount BaseMaterialx::Engine => '/base_part'
  
  resource :session
  
  root :to => "authentify::sessions#new"
  match '/signin',  :to => 'authentify::sessions#new'
  match '/signout', :to => 'authentify::sessions#destroy'
  match '/user_menus', :to => 'user_menus#index'
  match '/view_handler', :to => 'authentify::application#view_handler'
end
