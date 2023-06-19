class RecipesController < ApplicationController
  include ApiKeyAuthenticatable
  prepend_before_action :authenticate_with_api_key!

  def create; end
end
