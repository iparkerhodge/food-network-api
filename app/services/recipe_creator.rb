class RecipeCreator < ApplicationService
  attr_reader :source, :title, :author, :author_profile, :ingredients,
              :directions, :categories, :image_url, :level, :servings,
              :total_time, :time_descriptions

  def initialize(**kwargs)
    @recipe = Recipe.new
    @recipe.directions = kwargs[:directions]
    @recipe.image_url = kwargs[:image_url]
    @recipe.ingredients = kwargs[:ingredients]
    @recipe.level = kwargs[:level]
    @recipe.servings = kwargs[:servings]
    @recipe.source = kwargs[:source]
    @recipe.title = kwargs[:title]
    @recipe.total_time = kwargs[:total_time]
    @recipe.time_descriptions = kwargs[:time_descriptions]

    @author = Author.new
    @author.name = kwargs[:author]
    @author.profile = kwargs[:author_profile]

    @categories = kwargs[:categories]
  end

  def call
    ActiveRecord::Base.transaction do
      @author.save!
      @author.recipes << @recipe

      @categories.each do |name|
        category = Category.find_or_create_by!(name: name)
        @recipe.categories << category
      end
    end
  end
end
