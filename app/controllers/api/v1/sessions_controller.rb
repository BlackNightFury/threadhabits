class Api::V1::SessionsController < ActionController::Base

	def create
		person = Person.where(email: params[:email]).first
		puts person.inspect
		if person&.valid_password?(params[:password])
			person.save
			render json: person.as_json, status: :created
		else
			head(:unauthorized)
		end
	end

end
