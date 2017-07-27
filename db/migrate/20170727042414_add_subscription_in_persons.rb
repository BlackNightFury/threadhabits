class AddSubscriptionInPersons < ActiveRecord::Migration[5.0]
  def change
  	add_column :people, :subscription_type, :integer, default: 1
  	add_column :people, :subscription_created_at, :datetime  	
  end
end
