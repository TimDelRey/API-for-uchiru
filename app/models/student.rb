# frozen_string_literal: true

class Student < ApplicationRecord
  belongs_to :study_class
  before_create :generate_auth_token

  validates :first_name, format: { with: /[a-zA-Zа-яА-ЯёЁ]/ }
  validates :last_name, format: { with: /[a-zA-Zа-яА-ЯёЁ]/ }
  validates :surname, format: { with: /[a-zA-Zа-яА-ЯёЁ]/ }

  private

  def generate_auth_token
    secret_salt = Rails.application.secret_key_base
    self.auth_token = Digest::SHA256.hexdigest("#{SecureRandom.uuid}#{secret_salt}")
  end
end
