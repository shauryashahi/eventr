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

      post 'groups', to:"groups#create"
      get 'event-groups', to:"groups#event_groups"
      get 'user-groups', to:"groups#user_groups"
      get 'group-members/:id', to:"groups#group_members"
      post 'join-group/:id', to:"groups#join_group"
      # post 'groups/:id/invite', to:"groups#invite_members"

      post 'confirm-member/:id', to:"members#confirm_member"
      post 'make-admin/:id', to:"members#make_admin"
      post 'mark-attendance/:id', to:"members#mark_attendance"

    end
  end
end

