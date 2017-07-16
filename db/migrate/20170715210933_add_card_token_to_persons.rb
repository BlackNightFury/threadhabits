class AddCardTokenToPersons < ActiveRecord::Migration[5.0]
  def change
  	add_column :people, :card, :json
  	add_column :people, :stripe_token, :string
  end
end
