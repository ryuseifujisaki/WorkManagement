class Api::V1::CurrentUserApiController < ApplicationController
  before_action :authenticate_api_user!
  def show
    @user= current_api_user
    render json: @user
  end

  def new
    @user = current_user.id
  end

end