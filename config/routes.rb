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
  get "creations/delete_category", to: "creations#delete_category", as: 'delete_category'
  get "creations/update_active_category", to: "creations#update_active_category", as: 'update_active_category'
  post "creations/update_category_titles", to: "creations#update_category_titles", as: 'update_category_titles'
  get "creations/make_category_form", to: "creations#make_category_form", as: 'make_category_form'
  post "creations/add_question", to: "creations#add_question", as: 'add_question'
  get "creations/delete_question", to: "creations#delete_question", as: 'delete_question'
  get "creations/page_update", to: "creations#page_update", as: 'page_update'
  

  get "dashboard/page_update", to: "dashboard#page_update", as: 'page_update_dashboard'
  post "dashboard/share_rfi", to: "dashboard#share_rfi", as: 'share_rfi'
  post "dashboard/delete_rfi", to: "dashboard#delete_rfi", as: 'delete_rfi'
  get "dashboard/navigate_rfi", to: "dashboard#navigate_rfi", as: 'navigate_rfi'
  get "dashboard/make_title_form", to: "dashboard#make_title_form", as: 'make_title_form'
  post "dashboard/update_rfi_title", to: "dashboard#update_rfi_title", as: 'update_rfi_title'
  get "dashboard/home", to: "dashboard#dashboard", as: 'dashboard'
  get "dashboard/active_rfis", to: "dashboard#active_rfis", as: 'active_rfis'
  get "dashboard/load_charts", to: "dashboard#load_charts", as: 'load_charts'
  post "dashboard/refresh_charts", to: "dashboard#refresh_charts", as: 'refresh_charts'
  post "dashboard/update_selected", to: "dashboard#update_selected", as: 'update_selected'

  get "responses/load_rfi_response/:rfi_id", to: "responses#load_rfi_response", as: 'load_rfi_response'
  get "responses/update_active_category_response", to: "responses#update_active_category_response", as: 'update_active_category_response'
  get "responses/response_page_update", to: "responses#response_page_update", as: 'response_page_update'
  get "responses/edit_content", to: "responses#edit_content", as: 'edit_content'
  post "responses/save_content", to: "responses#save_content", as: 'save_content'
  post "responses/collapse_content", to: "responses#collapse_content", as: 'collapse_content'
  post "responses/submit", to: "responses#submit", as: 'submit'
  
  get "evaluation/load_rfi_evaluation/:rfi_id", to: "evaluation#load_rfi_evaluation", as: 'load_rfi_evaluation'
  get "evaluation/toggle_category", to: "evaluation#toggle_category", as: 'toggle_category'
  get "evaluation/update_active_question", to: "evaluation#update_active_question", as: 'update_active_question'
  get "evaluation/evaluation_page_update", to: "evaluation#evaluation_page_update", as: 'evaluation_page_update'
  post "evaluation/save_rating", to: "evaluation#save_rating", as: 'save_rating'
  
  resources :evaluation
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
