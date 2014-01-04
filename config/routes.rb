LooklaDev::Application.routes.draw do
  get "paiement/create"
  get "paiement/index"
  get "paiement/show"
  get "paiement/update"
  get "event/index"
  # get "event/show"
  get "admin/index"
  get "personne/index"
  # get "personne/show/"
  get "personne/edit"
  get "home/index"
  get "commande/index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  get '/personne/:id', to: 'personne#show', as: :personneshow

  get "product", to: 'product#index', as: :product_index
  get '/product/:id', to: 'product#show', as: :productshow
  get '/product/event/:event', to: 'product#index', as: :productevent
  
  get '/commande/:id', to: 'commande#show', as: :commandeshow
  get '/event/:id', to: 'event#show', as: :eventshow
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
