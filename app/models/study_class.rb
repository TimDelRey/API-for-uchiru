class StudyClass < ApplicationRecord
  self.table_name = "classes"
  
  attr_readonly :id, :students_count

  has_many :students
  belongs_to :school

end
