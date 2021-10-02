Rails.application.routes.draw do
  resources :user_works
  resources :works

  namespace 'api' do
    namespace 'auth' do 
      get "registrations" => "registrations#account_update_params"
      post "registrations" => "registrations#account_update_params"
    end

    namespace 'v1' do
      get "current_user/show" => "current_user_api#show"
      get "current_user/new" => "current_user_api#new"
      get "current_user/get_user_detail" => "current_user_api#get_user_detail"
    end

  end
 
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }
  end
end
