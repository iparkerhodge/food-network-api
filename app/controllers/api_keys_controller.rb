# frozen_string_literal: true

# Controller for API Keys
class ApiKeysController < ApplicationController
  include ApiKeyAuthenticatable
  prepend_before_action :authenticate_with_api_key!, only: %i[index]

  def index
    render json: current_user.api_keys
  end

  def create
    authenticate_with_http_basic do |email, password|
      user = User.find_by email: email

      if user&.authenticate(password)
        api_key = user.api_keys.create! token: SecureRandom.hex

        render json: api_key, status: :created and return
      end
    end

    render status: :unauthorized
  end

  def destroy
    authenticate_with_http_basic do |email, password|
      user = User.find_by email: email

      if user&.authenticate(password)
        api_key = user.api_keys.find(params[:id])
        api_key.update deleted_at: Time.now

        new_api_key = user.api_keys.create! token: SecureRandom.hex
        render json: new_api_key, status: :created and return
      end
    end
  end
end
