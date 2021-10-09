class Api::V1::CurrentUserApiController < ApplicationController
  before_action :authenticate_api_user!
  def show
    @user= current_api_user
    render json: { data: @user }
  end

  def get_user_detail
    @user = current_api_user
    user_detail = {
     user: @user
    }
    render json: user_detail
  end

end