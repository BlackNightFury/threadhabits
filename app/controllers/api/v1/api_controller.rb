class Api::V1::ApiController < ActionController::Base
	respond_to :json
	helper_method :current_user

	def current_user
	   @current_user ||= Person.find_by_authentication_token(request.headers['User-Token']) if request.headers['User-Token'].present?
	end

	def authenticate_user!
	  return render json:{error:'401 Unauthorized!'},status: 401 unless current_user
	end
end	