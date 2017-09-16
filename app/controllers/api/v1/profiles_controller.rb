class Api::V1::ProfilesController < ActionController::Base

  before_action :set_profile

  def show
    render json: @person.profile_as_json(params[:page])
  end

  private

  def set_profile
    @person = Person.find_by_username(params[:username])
  end

end
