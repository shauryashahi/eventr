Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show]
      resources :groups
      post 'login', to:"auth#login_with_fb"
      post 'logout', to:"auth#logout"
      get 'events', to:"events#index"
      get 'events/:id', to:"events#show"
    end
  end
end

