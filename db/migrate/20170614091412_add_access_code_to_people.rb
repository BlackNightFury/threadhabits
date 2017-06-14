class AddAccessCodeToPeople < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :access_code, :string
  end
end
