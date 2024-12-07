# frozen_string_literal: true

class School < ApplicationRecord
  has_many :study_classes
  has_many :students
end
