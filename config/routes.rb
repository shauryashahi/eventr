Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :groups
      get 'user-profile', to:"users#user_profile"
      post 'login', to:"auth#login_with_fb"
      post 'logout', to:"auth#logout"
      get 'events', to:"events#index"
      get 'events/:id', to:"events#show"
      get 'nearby-events', to:"events#events_by_location"
      post 'rsvp-event', to:"events#rsvp_to_event"
    end
  end
end

