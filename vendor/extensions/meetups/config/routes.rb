Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :meetups do
    resources :meetups, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :meetups, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :meetups, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
