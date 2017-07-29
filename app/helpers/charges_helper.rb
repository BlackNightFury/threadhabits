module ChargesHelper
  include ActionView::Helpers::NumberHelper

  def to_dollar(amount)
    number_to_currency(amount)
  end

  def stripe_params
    {
      key: ENV['stripe_publishable_key'],
      locale: 'auto',
      email: current_person.email,
      amount: params[:amount].to_f * 100
    }
  end
end
