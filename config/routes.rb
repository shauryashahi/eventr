Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show]
      resources :groups
      post 'login', to:"auth#login_with_fb"
      post 'logout', to:"auth#logout"
    end
  end
end

