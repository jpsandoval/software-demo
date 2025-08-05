class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.string :nickname
      t.integer :age
      t.string :house
      t.float :grade
      t.string :hobby
      t.string :favorite_color
      t.string :pet_name
      t.string :pet_kind

      t.timestamps
    end
  end
end
