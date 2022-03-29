class CreateErpData < ActiveRecord::Migration[7.0]
  def change
    create_table :erp_data do |t|
      t.string :entity_id, null: false
      t.belongs_to :order, null: false, index: false
      t.index [:entity_id], name: :index_erp_data_on_entity_id_uniq, unique: true
      t.index [:order_id], name: :index_erp_data_on_order_id_uniq, unique: true

      t.timestamps
    end
  end
end
