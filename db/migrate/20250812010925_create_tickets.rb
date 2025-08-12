class CreateTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :tickets do |t|
      t.string :full_name
      t.string :rut
      t.string :code
      t.boolean :paid
      t.boolean :checked_in

      t.timestamps
    end
  end
end
