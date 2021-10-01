Rails.application.routes.draw do
  resources :user_works
  resources :works

  namespace 'api' do
    namespace 'auth' do 
    end

    namespace 'v1' do
    end

  end
 
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }
  end
end
