module ChargesHelper
  include ActionView::Helpers::NumberHelper

  def to_dollar(amount)
    number_to_currency(amount)
  end

  def stripe_params
    {
      key: 'pk_test_FjE0tNXjjuewmORlrYp3SNQt',
      locale: 'auto',
      email: current_person.email,
      amount: params[:amount].to_f * 100
    }
  end
end
