# frozen_string_literal: true

class StudyClass < ApplicationRecord
  validates :number, presence: true,
                    numericality: { only_integer: true, greater_than: 0 }
  validates :letter, format: { with: /A[a-zA-Zа-яА-ЯёЁ]z/ }

  has_many :students
  belongs_to :school
end
