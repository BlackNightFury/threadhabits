class Api::V1::RegistrationsController < ActionController::Base

  def create
    user = Person.new(person_params)
    user.password_confirmation = person_params[:password]
    user.skip_confirmation! unless user.nil?
    if user.save
      render json: user.as_json, status: :created
    else
      warden.custom_failure!
      render json: user.errors, status: :unprocessable_entity
    end
  end

	private

	def person_params
		params.require(:person).permit(:email,:first_name, :last_name, :username, :password)
	end
end
