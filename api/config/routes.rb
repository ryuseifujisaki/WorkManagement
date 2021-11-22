Rails.application.routes.draw do
  resources :user_works
  resources :works

  put "user_work/cancell" =>"user_works#cancell"

  namespace 'api' do
    namespace 'auth' do 
      get "registrations" => "registrations#account_update_params"
      post "registrations" => "registrations#account_update_params"
    end

    namespace 'v1' do
      #user
      get "current_user/show" => "current_user_api#show"
      get "current_user/new" => "current_user_api#new"
      #userの全情報ルート
      get "current_user/index" => "current_user_api#index"
      #user_signin情報取得api
      get "current_user/get_user_signin" => "current_user_api#get_user_signin"
      #userデータ消去
      put "current_user/user_delete" => "current_user_api#user_delete"
      #admin
      get "current_admin/show" => "current_admin_api#show"
      #admin_signin情報取得api
      get "current_admin/get_admin_signin" => "current_admin_api#get_admin_signin"
      #work_user
      get "work_user/get_work_user/:id" => "work_user_api#get_work_user"
      #work_detail
      get "work_user/get_work_detail" => "work_user_api#get_work_detail"
    end

  end
 
  #devise_token_auth
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }
    mount_devise_token_auth_for 'Admin', at: 'admin' ,controllers: {
      registrations: 'api/auth/registrations'
    }   
  end
end
