class CreateCreditCards < ActiveRecord::Migration[7.0]
  def change
    create_table :credit_cards do |t|
      t.string :number, null: false
      t.string :name, null: false
      t.string :exp_month, null: false
      t.string :exp_year, null: false
      t.string :cvc, null: false

      t.timestamps
    end
  end
end
