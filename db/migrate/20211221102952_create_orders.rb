class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.belongs_to :shipping_address, null: false, foreign_key: {to_table: :addresses}
      t.belongs_to :credit_card, null: false, foreign_key: true
      t.string :email, null: false

      t.timestamps
    end
  end
end
