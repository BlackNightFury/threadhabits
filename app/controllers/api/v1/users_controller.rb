class Api::V1::UsersController < Api::V1::ApiController
  # skip_before_filter  :verify_authenticity_token 
  before_filter :authenticate_user!
  

 #first_name, last_name, location, about_you, avatar, cover_photo, phone_number, about_you, facebook_profile, twitter_profile, instagram_profile, avatar and covert_photo will be attached as multi-part
  #POST /api/v1/updateProfile
  #Header User-Token
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

      render json: @user.as_json.merge(avatar_url: @user.avatar.try(:url), cover_url: @user.cover_image.try(:url), location: @user.address, notification_preferences: @user.preferences.notifications), status: :ok
    else
      render json: @user.errors.as_json, status: :unprocessable_entity
    end
  end

  #POST /api/v1/updateAccount
  #params email, username
  #Header User-Token
  def update_account
    @user = @current_user
    @user.email = params[:email] if params[:email].present?
    @user.username = params[:username] if params[:username].present?
    if @user.save
      render json: @user.as_json.merge(avatar_url: @user.avatar.try(:url), cover_url: @user.cover_image.try(:url), location: @user.address, notification_preferences: @user.preferences.notifications), status: :ok
    else
      render json: @user.errors.as_json, status: :unprocessable_entity
    end
  end

  #POST /api/v1/updatePassword
  #params password
  #Header User-Token
  def update_password
    @user = @current_user
    @user.password = params[:password] if params[:password].present?
    if @user.save
      render json: @user.as_json.merge(avatar_url: @user.avatar.try(:url), cover_url: @user.cover_image.try(:url), location: @user.address, notification_preferences: @user.preferences.notifications), status: :ok
    else
      render json: @user.errors.as_json, status: :unprocessable_entity
    end
  end

  
  #POST /api/v1/updateNotification
  #params {"notification_preferences" : {"new_message" : "true", "new_payment" : "true", "new_follower" : "true"}  }
  #Header User-Token
  #Contwnt-Type: application/json
  def update_notification
    @user = @current_user
     @preference = @current_user.preferences.notifications.first
    if @preference.blank?
      @preference = @current_user.preferences.notifications.build(preference_type: "Notification")
    end
    @preference.data = params[:notification_preferences] || {}
    if @preference.save
      render json: @user.as_json.merge(avatar_url: @user.avatar.try(:url), cover_url: @user.cover_image.try(:url), location: @user.address, notification_preferences: @user.preferences.notifications), status: :ok
    else
      render json: @preference.errors.as_json, status: :unprocessable_entity
    end
  end


  #POST /api/v1/updatePayment
  #params paypal_id
  #Header User-Token
  def update_payment
    @user = @current_user
    @user.paypal_id = params[:paypal_id] if params[:paypal_id].present?
    if @user.save
      render json: @user.as_json.merge(avatar_url: @user.avatar.try(:url), cover_url: @user.cover_image.try(:url), location: @user.address, notification_preferences: @user.preferences.notifications), status: :ok
    else
      render json: @user.errors.as_json, status: :unprocessable_entity
    end

    card_detail = params["card_token"]["card"].as_json
    stripe_token = params["card_token"]["id"]
    customer = Stripe::Customer.create source: stripe_token
    if current_person.update_attributes({card: card_detail, stripe_token: stripe_token, stripe_customer: customer.id})
      render json: { success: true, notice: "Card details updated successfully" }
    else
      render json: { success: false, notice: "Something went wrong please try again." }
    end
  end


  #POST /api/v1/updateCard
  #params {"card_token"=>{"id"=>"tok_1B4T4bIu8gpmxJx9TENQJNnO", "object"=>"token", "card"=>{"id"=>"card_1B4T4bIu8gpmxJx9F3RV0Qsh", "object"=>"card", "address_city"=>"", "address_country"=>"", "address_line1"=>"", "address_line1_check"=>"", "address_line2"=>"", "address_state"=>"", "address_zip"=>"11009", "address_zip_check"=>"unchecked", "brand"=>"Visa", "country"=>"US", "cvc_check"=>"unchecked", "dynamic_last4"=>"", "exp_month"=>"4", "exp_year"=>"2019", "funding"=>"credit", "last4"=>"4242", "name"=>"", "tokenization_method"=>""}, "client_ip"=>"112.196.147.19", "created"=>"1505994149", "livemode"=>"false", "type"=>"card", "used"=>"false"}}
  #Header User-Token
  def update_card
    card_detail = params["card_token"]["card"].as_json
    stripe_token = params["card_token"]["id"]
    customer = Stripe::Customer.create source: stripe_token
    if current_person.update_attributes({card: card_detail, stripe_token: stripe_token, stripe_customer: customer.id})
      render json: { success: true, notice: "Card details updated successfully" }
    else
      render json: { success: false, notice: "Something went wrong please try again." }
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
