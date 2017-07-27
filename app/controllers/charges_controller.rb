class ChargesController < ApplicationController

  before_action :create_stripe_customer, only: :create

  def new
  end

  def create
    current_person.update_attributes(subscription_type: params[:subscription_type], subscription_created_at: DateTime.now)
    redirect_to  payments_settings_path
  end

  private


  def create_stripe_customer
    if current_person.stripe_customer.nil?
      current_person.setup_stripe_account(params[:stripeEmail], params[:stripeToken])
    end
  end

  def charge_params(charge)
    {
      amount: charge.amount,
      paid: charge.paid,
      charge_id: charge.id,
      payed_at: charge.created,
      plan: params[:plan],
      transaction_type: charge.object
    }
  end
end
