class ApplicationController < ActionController::API
  # before_filter :authenticate_user!
  include DeviseTokenAuth::Concerns::SetUserByToken
end
