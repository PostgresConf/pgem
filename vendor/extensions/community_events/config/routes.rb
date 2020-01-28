Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :community_events do
    resources :community_events, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :community_events, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :community_events, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
