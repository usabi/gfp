Gfp::Application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :teachers

 # resources :qualifyingentity_tlresults

  resources :profiles do
    get 'edit_tlresults', :on => :member
    put 'update_tlresults', :on => :member
    get 'edit_scores', :on => :member
    put 'update_scores', :on => :member
    get 'edit_global_scores', :on => :member
    put 'update_global_scores', :on => :member
    get 'edit_tlresult_percentages', :on => :member
    resources :students do
      resources :points
      resources :absences
      resources :incidents
      resources :observations
    end
    resources :qualifyingentities
    resources :classroom_diaries
    resources :own_tlresults
  end

  resources :students do
    collection do
      post :import 
      get :search_by_dni
      get :all_students
    end
  end

  resources :teachers do
    post 'change_current_profile'
  end

  # Para realizar select anidados
  resources :trainercycles do
    resources :matters
    get 'update_matter', :on => :member
  end

  resources :classrooms do
    post 'csv_import', :on => :member
    resources :students
  end

  #Ruta para usar en el momento de implementar ajax
  resources :institutes do
    get 'search', :on => :collection
  end

  resources :scores
  resources :average_scores

  root :to => "pages#home"
  match ':controller(/:action(/:id(.:format)))'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
