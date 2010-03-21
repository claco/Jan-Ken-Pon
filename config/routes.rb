ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => 'home'
  
  map.login  'login',  :controller => 'authentication', :action => 'login'
  map.logout 'logout', :controller => 'authentication', :action => 'logout'
  map.register 'register', :controller => 'account', :action => 'create'
  map.account 'account', :controller => 'account', :action => 'edit'
  map.confirm 'confirm/:token', :controller => 'account', :action => 'confirm'
  map.resend 'account/resend', :controller => 'account', :action => 'resend'
  map.forgot 'forgot', :controller => 'account', :action => 'forgot'
  map.reset 'reset/:token', :controller => 'account', :action => 'reset'

  map.resources :games
  map.play_game 'games/play/:id', :controller => 'games', :action => 'play'
  map.join_game 'games/join/:id', :controller => 'games', :action => 'join'
  map.deliver   'games/play/:id/deliver/:weapon', :controller => 'games', :action => 'deliver'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
