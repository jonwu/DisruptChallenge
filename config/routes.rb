Rails.application.routes.draw do
  
  devise_for :users
  devise_scope :user do
    get "signup", to: "devise/registrations#new"
    get "login", to: "devise/sessions#new"
    get "logout", to: "devise/sessions#destroy"
  end


  post "creations/create_rfi", to: "creations#create_rfi", as: 'create_rfi'
  get "creations/load_rfi/:rfi_id", to: "creations#load_rfi", as: 'load_rfi'
  post "creations/add_new_category", to: "creations#add_new_category", as: 'add_new_category'
  get "creations/update_active_category", to: "creations#update_active_category", as: 'update_active_category'
  post "creations/update_category_titles", to: "creations#update_category_titles", as: 'update_category_titles'
  get "creations/make_category_form", to: "creations#make_category_form", as: 'make_category_form'
  post "creations/check_question", to: "creations#check_question", as: 'check_question'
  post "creations/add_question", to: "creations#add_question", as: 'add_question'
  get "creations/delete_question", to: "creations#delete_question", as: 'delete_question'
  resources :creations
  resources :dashboard
  resources :responses
  root 'homepage#index'


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
end
