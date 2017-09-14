class Api::V1::SessionsController < ActionController::Base

	def create
		person = Person.find_by_email_or_username(params[:email])
		if person&.valid_password?(params[:password])
			person.save
			render json: person.as_json, status: :created
		else
			render json: {message: "Email/Username or password are incorrect"}, status: :unauthorized
		end
	end
end
