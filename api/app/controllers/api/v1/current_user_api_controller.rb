class Api::V1::CurrentUserApiController < ApplicationController
  #before_action :authenticate_api_user!

  #現在ログインしているuser情報を取得する
  def show
    @user= current_api_user
    render json: { data: @user }
  end

  #全ユーザ情報取得
  def index
    @user = User.all
    render json:{data: @user}
  end

  # userデータ消去
  def user_delete
    @user = User.find(user_params[:id])
    @user.destroy
  end

  # userがサインインしているかの情報取得
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

  private
  def user_params
    params.require(:current_user_api).permit(:id)
  end

end