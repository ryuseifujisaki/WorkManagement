class Api::V1::WorkUserApiController < ApplicationController

  def get_work_user
    @work = Work.find(params[:id])
    workusers =@work.users
    usersname  =[]
    for workuser in workusers 
      user_name = workuser.name
      usersname << {
        name: user_name
      }
    end
    render json:usersname
  end
end