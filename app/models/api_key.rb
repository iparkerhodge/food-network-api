# frozen_string_literal: true

# A Model for API Keys
class ApiKey < ApplicationRecord
  HMAC_SECRET_KEY = Rails.application.credentials.api_key_hmac_secret_key
  belongs_to :users

  before_create :generate_token_hmac_digest

  attr_accessor :token

  def self.authenticate_by_token!(token)
    digest = OpenSSL::HMAC.hexdigest 'SHA256', HMAC_SECRET_KEY, token

    find_by! token_digest: digest
  end

  def self.authenticate_by_token(token)
    authenticate_by_token! token
  rescue ActiveRecord::RecordNotFound
    nil
  end

  # Add virtual token attribute to serializable attributes, and exclude
  # the token's HMAC digest
  def serializable_hash(options = nil)
    h = super options.merge(except: 'token_digest')
    h.merge! 'token' => token if token.present?
    h
  end

  private

  def generate_token_hmac_digest
    raise ActiveRecord::RecordInvalid, 'token is required' unless
      token.present?

    digest = OpenSSL::HMAC.hexdigest 'SHA256', HMAC_SECRET_KEY, token

    self.token_digest = digest
  end
end
