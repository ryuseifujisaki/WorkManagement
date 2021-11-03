class Api::V1::CurrentAdminApiController < ApplicationController
  #before_action :authenticate_api_admin!
  def show
    @admin= current_api_admin
    render json: { data: @admin }
  end

  def get_admin_signin
    @admin = current_api_admin
    @admin
   flag = ""
   #nilの場合true
    if @admin.nil? == false
      flag = true
    else
      flag = false
    end
    admin_check ={
      flag: flag
    }
    render json: admin_check
  end
end
