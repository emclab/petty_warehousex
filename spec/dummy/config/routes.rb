Rails.application.routes.draw do

  mount PettyWarehousex::Engine => "/petty_warehousex"
  mount Authentify::Engine => "/authentify"
  mount Commonx::Engine => "/commonx"
  mount Supplierx::Engine => '/supplier'
  mount Searchx::Engine => '/searchx'
  mount ExtConstructionProjectx::Engine => '/project'
  mount Kustomerx::Engine => '/customer'
  mount BaseMaterialx::Engine => '/base_part'
  
  
  root :to => "authentify/sessions#new"
  get '/signin',  :to => 'authentify/sessions#new'
  get '/signout', :to => 'authentify/sessions#destroy'
  get '/user_menus', :to => 'user_menus#index'
  get '/view_handler', :to => 'authentify/application#view_handler'
end
