class Api::V1::WorkUserApiController < ApplicationController
  # workに参加しているuserのapi作成
  def get_work_user
    @work = Work.find(params[:id])
    workusers =@work.users
    usersname  = []
    for workuser in workusers 
      user_name = workuser.name
      usersname << {
        name: user_name
      }
    end
    render json:  usersname
  end

  def get_work_detail
    @work = Work.all
    workdetails = []
    for work in @work
      usersname  = []
      work_name = work.name
      work_limit = work.limit
      work_day = work.day
      work_where = work.where
      work_money = work.money
      work_carfare = work.carfare
      work_content = work.content
      work_cloth = work.cloth
      work_belonging = work.belonging
      work_other = work.other
      work_users = work.users
      for work_user in work_users 
        user_name = work_user.name
        usersname.push(user_name)
      end
      workdetails << {
        name: work_name,
        limit: work_limit,
        day: work_day,
        where: work_where,
        money: work_money,
        carfare: work_carfare,
        content: work_content,
        cloth: work_cloth,
        belonging: work_belonging,
        other: work_other,
        usernames: usersname,
      }
     end
      render json: workdetails
  end
end