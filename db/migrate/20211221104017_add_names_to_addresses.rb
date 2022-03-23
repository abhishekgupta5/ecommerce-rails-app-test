class AddNamesToAddresses < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :first_name, :string, null: false
    add_column :addresses, :last_name, :string, null: false
  end
end
