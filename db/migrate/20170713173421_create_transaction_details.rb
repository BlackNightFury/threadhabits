class CreateTransactionDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :transaction_details do |t|
    	t.string :amount_of_transaction		
    	t.string :transaction_id
    	t.string :transaction_status
    	t.string :buyer
    	t.string :seller
    	t.integer :buyer_id
    	t.integer :seller_id
      t.timestamps
    end
  end
end
