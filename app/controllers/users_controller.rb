# frozen_string_literal: true

# Controller for Users (sign up, login)
# For use with CLI (https://github.com/iparkerhodge/food-network-api-cli)
class UsersController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  def index
    authenticate_with_http_basic do |email, password|
      @user = User.find_by email: email

      if @user&.authenticate(password)
        @api_keys = @user.api_keys
        render json: UserWithKeysResource.new(@user), status: 200 and return
      end
    end
  end

  def create
    @user = User.create!(user_params)
    if @user
      render json: UserResource.new(@user).serialize,
             status: :created and return
    end

    render status: :unprocessable_entity and return
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
