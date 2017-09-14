class Api::V1::PasswordsController < ActionController::Base

  def create
    user = Person.find_by_email_or_username(params["email"])
    if user&.present?
      user.send_reset_password_instructions
      render json: {message: "You will receive an email with instructions on how to reset your password in a few minutes."}, status: :created
    else
      render json: {message: "Email or Username not found. Please check and try again."}, status: :not_found
    end
  end
end
