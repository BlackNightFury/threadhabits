class Payments::PaypalController < ApplicationController
  protect_from_forgery except: [:webhook]
  before_action :authenticate_person!, except: [:webhook, :confirm]

  def checkout
    @listing = Listing.find(params[:listing_id])
    if !@listing.person.is_seller?
      flash[:alert] = "Can't do payment with paypal at the moment. Contact tech support"
      redirect_to detail_listings_path(@listing.slug) and return
    end

    cost = (@listing.price)
    values = {
            business: @listing.person.paypal_id,
            cmd: "_xclick",
            upload: 1,
            return: "#{Rails.application.secrets.app_host}#{payments_confirm_checkout_path}",
            amount: cost,
            item_name: @listing.name,
            item_number: @listing.id,
            quantity: '1',
            notify_url: "#{Rails.application.secrets.app_host}/payments/webhook",
            custom: { buyer_id: current_person.id, seller_id: @listing.person.id}.to_json
        }

    redirect_to "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end

  def confirm
    redirect_to "/"
  end

  def webhook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      if params[:custom].present?
        custom = JSON.parse(params[:custom])
        buyer = Person.find(custom["buyer_id"])
        seller = Person.find(custom["seller_id"])
        unless TransactionDetail.find_by_transaction_id(params[:txn_id]).present?
          transaction = TransactionDetail.create(amount_of_transaction: params[:payment_gross], transaction_id: params[:txn_id], transaction_status: status, buyer: buyer.email, seller: seller.email, buyer_id: buyer.id, seller_id: seller.id)
          if current_person.subcription_type = 2 && current_person.subscription_created_at + 1.momth >= DateTime.now
            #no payment
          elsif current_person.subcription_type = 3 && current_person.subscription_created_at + 1.year >= DateTime.now
            #no charges
          else
            commision = (transaction.amount_of_transaction.to_f * 3.50)/100
            customer = Stripe::Customer.retrieve(seller.stripe_customer)
            charge = Stripe::Charge.create customer: customer.id, amount: (commision * 100).to_i, description: '', currency: 'usd'
          end
          NotificationsMailer.payment_processed(buyer).deliver!
        else
          render nothing: true and return
        end
      end
    end
    render nothing: true
  end
end
