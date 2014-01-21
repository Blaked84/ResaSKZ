LooklaDev::Application.routes.draw do

  get "commande_products/check_nombre"
  post "commande_products/check_nombre"
  get "admin/index"
  get "admin/graph"
  get "home/index"
  resources :commandes do
    member do
      post :add_product
      post :remove_product
      get :catalogue
    end
    resources :paiements   
  end

  #charts
  get "chart/etatcommande" => "chart#etatcommande"
  get "chart/paiement" => "chart#paiement"
  get "chart/tbkcommandes" => "chart#tbkcommandes"
  get "chart/statsbus/:categorie_id/:event_id" => "chart#statsbus", as: :statsbus 
  
  resources :events do
    resources :products
  end 
  #paiements
  resources :paiements
  get 'paiements-check' => 'paiements#check', as: :check_paiement
  post 'paiements-import-csv' => 'paiements#csv_import', as: :csv_import
  resources :personnes do
    member do
      get 'personne_infos'
      post 'personne_infos' => "personnes#update_personne_infos"
      get 'add_commande'
    end
    resources :commandes do
      resources :events do
        resources :products
      end
    end
  end
  resources :products
  get 'productnmbr' => 'comandes#productnmbr'


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users do
    member do
      get 'cgu'
      post 'cgu'=>"users#cgu_accept"
      get 'user_infos'
      post 'user_infos'=>"users#update_user_infos"
      get 'dashboard'
      get 'parrainer'
      post 'parrainer'=>"users#create_parrainer"
      get 'new_personne'
    end
    collection do
      get 'to_moderate'
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  root :to => "home#index"


end
