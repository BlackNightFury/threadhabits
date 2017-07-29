class ChargesController < ApplicationController

  before_action :create_stripe_customer, only: :create

  def new
  end

  def create
    current_person.update_attributes(subscription_type: params[:subscription_type], subscription_created_at: DateTime.now)
    if current_person.card.present?
      if params[:subscription_type] != '1'
        customer = Stripe::Customer.retrieve(current_person.stripe_customer)
        if params[:subscription_type] == '2'
          Stripe::Subscription.create(
            :customer => customer.id,
            :plan => "basic-monthly",
          )
        elsif params[:subscription_type] == '3'
          Stripe::Subscription.create(
            :customer => customer.id,
            :plan => "basic-yearly",
          )
        end
        flash[:notice] = "You have subscribed with #{params[:plan]}"
        # charge = Stripe::Charge.create customer: customer.id, amount: (params[:amount].to_f * 100).to_i, description: '', currency: 'usd'
      end
    else
      flash[:notice] = "You must have your card information on file to select your payment plan."
    end
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
