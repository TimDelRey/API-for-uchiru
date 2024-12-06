# frozen_string_literal: true

class Student < ApplicationRecord
  # attr_readonly :id
  belongs_to :study_class
  before_create :generate_auth_token

  private

  def generate_auth_token
    secret_salt = Rails.application.secret_key_base
    self.auth_token = Digest::SHA256.hexdigest("#{SecureRandom.uuid}#{secret_salt}")
  end
end
