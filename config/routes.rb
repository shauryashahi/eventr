Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'user-profile', to:"users#user_profile"
      post 'login', to:"auth#login_with_fb"
      post 'logout', to:"auth#logout"
      get 'events', to:"events#index"
      get 'events/:id', to:"events#show"
      get 'nearby-events', to:"events#events_by_location"
      post 'rsvp-event', to:"events#rsvp_to_event"
      get 'event-groups', to:"groups#event_groups"
      get 'user-groups', to:"groups#user_groups"
      get 'group-members/:id', to:"groups#group_members"
      # post 'groups', to:"groups#create"
      # post 'groups/:id/invite', to:"groups#invite_members"
      # post 'join-group/:id', to:"groups#join_group"
      # post 'confirm-member/:id', to:"groups#confirm_member"
      # delete 'groups/:id', to:"groups#destroy"
    end
  end
end

