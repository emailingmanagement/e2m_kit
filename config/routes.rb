ActionController::Routing::Routes.draw do |map|
  map.resources :kits, :member => { :rules => :get, :congrats => :get } do |kit|
    kit.resources :subscriptions, :collection => { :select_region_and_city => :get } do |subscription|
      subscription.resources :partner_subscriptions
      subscription.resources :contacts, :collection => { :import => :post }
    end
  end

  map.namespace :admin do |admin|
    admin.resources :user_sessions
    admin.resources :users
    admin.resources :kits do |kit|
      kit.resources :partners do |partner|
        partner.resources :partner_subscriptions
      end
      kit.resources :sources
    end
    admin.resources :stats
  end

  map.logout 'logout', :controller => 'admin/user_sessions', :action => 'destroy'  
  map.root :controller => 'kits', :action => 'show'

  map.connect '/:id', :controller => 'kits', :action => 'show'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
