Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    invitations: "invitations"
  }
  devise_scope :user do
    get "signup", to: "devise/registrations#new"
    get "login", to: "devise/sessions#new"
    get "logout", to: "devise/sessions#destroy"
  end

  get "homepage", to: "homepage#index", as: 'homepage' 
  post "rfis/share", to: 'rfis#share', as: 'share'
  
  resources :rfis do
    resources :categories, shallow: true    
  end
  resources :invites do
    resources :categories, shallow: true
  end

  resources :categories, only: [:show, :edit, :update, :destroy], shallow: true do
    resources :questions
    resources :responses
  end

  get 'base/update_questions'
  get 'base/update_categories'

  post "responses/save_response", to: 'responses#save_response', as: 'save_response'
  get "/categories/:category_id/questions/page_update", to: "questions#page_update", as: 'questions_page_update'
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
