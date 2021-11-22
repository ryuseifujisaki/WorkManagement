class UserWorksController < ApplicationController
  before_action :set_user_work, only: [:show, :update, :destroy]

  # GET /user_works
  def index
    @user_works = UserWork.all
    render json: @user_works
  end

  # GET /user_works/1
  def show
    render json: @user_work
  end

  # POST /user_works
  def create
    # 登録しようとしているworkの検索
    @work = Work.find(user_work_params[:work_id])
    work_limit_num = (@work.limit).to_i
    puts work_limit_num
    #登録しているworkの現在の参加人数取得
    work_user_num = @work.users.length
    puts work_user_num
    #同じ条件のアクティブレコードがないかつ参加人数が超えてなければ登録させる
    if @user_work = (UserWork.find_by(user_id:user_work_params[:user_id] , work_id:user_work_params[:work_id])) == nil && (work_limit_num > work_user_num)
      @user_work = UserWork.new(user_work_params)
      if @user_work.save
        render json: @user_work, status: :created, location: @user_work
      else
        render json: @user_work.errors, status: :unprocessable_entity
      end
    
    end
  end

  # PATCH/PUT /user_works/1
  def update
    if @user_work.update(user_work_params)
      render json: @user_work
    else
      render json: @user_work.errors, status: :unprocessable_entity
    end
  end

  # # DELETE /user_works/1
  # def destroy
  # end

  #workに登録しているuserの削除
  def cancell
    @user_work=UserWork.where(user_id:user_work_params[:user_id] , work_id:user_work_params[:work_id])
    @user_work.destroy_all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_work
      @user_work = UserWork.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_work_params
      params.require(:user_work).permit(:user_id, :work_id)
    end
end
