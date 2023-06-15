# frozen_string_literal: true

# Controller for Users (sign up, login)
class UsersController < ApplicationController
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
