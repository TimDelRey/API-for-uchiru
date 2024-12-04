class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :surname
      t.references :class, foreign_key: true
      t.references :school, foreign_key: true
      
      t.timestamps
    end
  end
end
