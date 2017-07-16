class AddStripeCustomerToPersons < ActiveRecord::Migration[5.0]
  def change
  	add_column :people, :stripe_customer, :string
  end
end
