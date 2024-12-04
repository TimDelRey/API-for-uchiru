class Student < ApplicationRecord

  attr_readonly :id
  
  belongs_to :study_class

end
