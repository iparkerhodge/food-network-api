# frozen_string_literal: true

# A concern that allows controllers to require API key authentication
module ApiKeyAuthenticatable
  extend ActiveSupport::Concern

  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  attr_reader :current_api_key
  attr_reader :current_user

  # Use this to raise an error and automatically respond with a 401 HTTP status
  # code when API key authentication fails
  def authenticate_with_api_key!
    @current_user = authenticate_or_request_with_http_token(&method(:authenticator))
  end

  # Use this for optional API key authentication
  def authenticate_with_api_key
    @current_user = authenticate_with_http_token(&method(:authenticator))
  end

  private

  attr_writer :current_api_key, :current_user

  def authenticator(http_token, _options)
    @current_api_key = ApiKey.authenticate_by_token http_token

    current_api_key&.user
  end
end
