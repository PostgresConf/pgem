Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :sponsors do
    resources :sponsors, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :sponsors, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :sponsors, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end


  # Admin routes
  namespace :sponsors, :path => '' do
    namespace :admin, :path => "#{Refinery::Core.backend_route}/sponsors" do
      resources :sponsorship_levels, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
