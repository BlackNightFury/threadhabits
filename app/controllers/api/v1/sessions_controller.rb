class Api::V1::SessionsController < ActionController::Base

	def create
		person = Person.find_by_email_or_username(params[:email])
		if person&.valid_password?(params[:password])
			person.save
			render json: person.as_json.merge(avatar_url: person.avatar.try(:url), cover_url: person.cover_image.try(:url), location: person.address, notification_preferences: person.preferences.notifications), status: :created
		else
			render json: {message: "Email/Username or password are incorrect"}, status: :unauthorized
		end
	end
end
