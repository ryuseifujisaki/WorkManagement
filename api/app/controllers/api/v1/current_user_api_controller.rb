class Api::V1::CurrentUserApiController < ApplicationController
  #before_action :authenticate_api_user!
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


  def get_user_signin 
    @user = current_api_user
    @user
   flag = ""
   #nilの場合true
    if @user.nil? == false
      flag = true
    else
      flag = false
    end
    user_check ={
      flag: flag
    }
    render json: user_check
  end
end