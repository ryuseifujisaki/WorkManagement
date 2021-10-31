class Api::V1::CurrentAdminApiController < ApplicationController
  before_action :authenticate_api_admin!
  def show
    @admin= current_api_admin
    render json: { data: @admin }
  end
end
