class CreateStudyClasses < ActiveRecord::Migration[7.1]
  def change
    create_table :study_classes do |t|
      t.integer :number
      t.string :letter
      t.integer :student_count, default: 32
      t.references :school, foreign_key: true

      t.timestamps
    end
  end
end
