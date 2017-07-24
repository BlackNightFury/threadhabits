class RemoveAccessCodeFromPeople < ActiveRecord::Migration[5.0]
  def change
  	remove_column :people, :access_code
  end
end
