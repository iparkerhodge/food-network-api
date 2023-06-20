class RecipesController < ApplicationController
  include ApiKeyAuthenticatable
  prepend_before_action :authenticate_with_api_key!

  def create
    if @current_user&.admin
      r = JSON.parse(params['_json']).transform_keys!(&:to_sym)
      RecipeCreator.call(r)
      render status: :created
    else
      render status: :unauthorized
    end
  end
end
