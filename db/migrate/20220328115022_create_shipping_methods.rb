class CreateShippingMethods < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_methods do |t|
      t.string :name, null: false
      t.string :country, null: false
      t.integer :delivery_time_in_days, null: false

      t.index [:country], name: :index_shipping_methods_country_uniq, unique: true
      t.timestamps
    end
  end
end
