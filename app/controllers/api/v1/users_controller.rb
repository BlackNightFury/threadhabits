class Api::V1::UsersController < Api::V1::ApiController
  # skip_before_filter  :verify_authenticity_token 
  before_filter :authenticate_user!
  

 #first_name, last_name, location, about_you, avatar, cover_photo, phone_number, about_you, facebook_profile, twitter_profile, instagram_profile, avatar and covert_photo will be attached as multi-part
  #POST /api/v1/updateProfile
  def update
    @user = @current_user
    @user.first_name = params[:first_name] if params[:first_name].present?
    @user.last_name = params[:last_name] if params[:last_name].present?
    @user.about_you = params[:about_you] if params[:about_you].present?
    @user.phone_number = params[:phone_number] if params[:phone_number].present?
    @user.avatar = params[:avatar] if params[:avatar].present?
    @user.cover_image = params[:cover_image] if params[:cover_image].present?
    @user.facebook_profile = params[:facebook_profile] if params[:facebook_profile].present?
    @user.instagram_profile = params[:instagram_profile] if params[:instagram_profile].present?
    @user.twitter_profile = params[:twitter_profile] if params[:twitter_profile].present?

    if @user.save
      #update Location
      update_location

      render json: @user.as_json, status: :ok
    else
      render json: @user.errors.as_json, status: :unprocessable_entity
    end
  end

  #POST /api/v1/updateAccount
  def update_account
    @user = @current_user
    @user.email = params[:email] if params[:email].present?
    @user.username = params[:username] if params[:username].present?
    if @user.save
      render json: @user.as_json, status: :ok
    else
      render json: @user.errors.as_json, status: :unprocessable_entity
    end
  end

  #POST /api/v1/updatePassword
  def update_password
    @user = @current_user
    @user.password = params[:password] if params[:password].present?
    if @user.save
      render json: @user.as_json, status: :ok
    else
      render json: @user.errors.as_json, status: :unprocessable_entity
    end
  end

  private

  def update_location
    address = @user.address
    if address.present?
      address.location = params[:location]
      address.save
    else
      Address.create(:owner_type=> "Person",:owner_id=> @user.id, location: params[:location])
    end
  end   
end
