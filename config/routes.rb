Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # resources :groups
      get 'user-profile', to:"users#user_profile"
      post 'login', to:"auth#login_with_fb"
      post 'logout', to:"auth#logout"
      get 'events', to:"events#index"
      get 'events/:id', to:"events#show"
      # get 'events/nearby', to:"events#events_by_location"
      # post 'events/rsvp', to:"events#rsvp_to_event"
    end
  end
end

