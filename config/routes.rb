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


  post "creations/create_rfi", to: "creations#create_rfi", as: 'creations_create_rfi'
  post "creations/add_new_category", to: "creations#add_new_category", as: 'creations_add_new_category'
  get "creations/delete_category", to: "creations#delete_category", as: 'creations_delete_category'
  get "creations/update_active_category", to: "creations#update_active_category", as: 'creations_update_active_category'
  post "creations/update_category_titles", to: "creations#update_category_titles", as: 'creations_update_category_titles'
  get "creations/make_category_form", to: "creations#make_category_form", as: 'creations_make_category_form'
  post "creations/add_question", to: "creations#add_question", as: 'creations_add_question'
  get "creations/delete_question", to: "creations#delete_question", as: 'creations_delete_question'
  get "creations/page_update", to: "creations#page_update", as: 'creations_page_update'
  

  get "dashboard/page_update", to: "dashboard#page_update", as: 'dashboard_page_update'
  post "dashboard/share_rfi", to: "dashboard#share_rfi", as: 'dashboard_share_rfi'
  post "dashboard/delete_rfi", to: "dashboard#delete_rfi", as: 'dashboard_delete_rfi'
  get "dashboard/navigate_rfi", to: "dashboard#navigate_rfi", as: 'dashboard_navigate_rfi'
  get "dashboard/make_title_form", to: "dashboard#make_title_form", as: 'dashboard_make_title_form'
  post "dashboard/update_rfi_title", to: "dashboard#update_rfi_title", as: 'dashboard_update_rfi_title'
  get "dashboard/home", to: "dashboard#dashboard", as: 'dashboard_home'
  get "dashboard/active_rfis", to: "dashboard#active_rfis", as: 'dashboard_active_rfis'

  get "responses/update_active_category", to: "responses#update_active_category", as: 'responses_update_active_category'
  get "responses/page_update", to: "responses#page_update", as: 'responses_page_update'
  get "responses/edit_content", to: "responses#edit_content", as: 'responses_edit_content'
  post "responses/save_content", to: "responses#save_content", as: 'responses_save_content'
  post "responses/collapse_content", to: "responses#collapse_content", as: 'responses_collapse_content'
  post "responses/submit", to: "responses#submit", as: 'responses_submit'
  
  get "evaluation/update_active_category", to: "evaluation#update_active_category", as: 'evaluation_update_active_category'
  get "evaluation/update_active_question", to: "evaluation#update_active_question", as: 'evaluation_update_active_question'
  get "evaluation/page_update", to: "evaluation#page_update", as: 'evaluation_page_update'
  get "evaluation/categories_page_update", to: "evaluation#categories_page_update", as: 'evaluation_categories_page_update'
  post "evaluation/save_rating", to: "evaluation#save_rating", as: 'evaluation_save_rating'
  

  get "active/:rfi_id", to: "active#index", as: 'load_active_rfi'
  resources :evaluation
  resources :creations
  resources :dashboard
  resources :responses
  resources :rfi
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
