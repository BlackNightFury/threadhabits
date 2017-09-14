class Api::V1::RegistrationsController < ActionController::Base

  def create
    user = Person.new(person_params)
    if user.save
      render json: {message: "User succesfully created"}, status: :created
      return
    else
      warden.custom_failure!
      render json: user.errors, status: :unprocessable_entity
    end
  end

	private

	def person_params
		params.require(:person).permit(:email,:first_name, :last_name, :username, :password, :password_confirmation)
	end
end
