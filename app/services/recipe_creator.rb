class RecipeCreator < ApplicationService
  attr_reader :source, :title, :author, :author_profile, :ingredients,
              :directions, :categories, :image_url, :level, :servings,
              :total_time, :time_descriptions

  def initialize(**kwargs)
    set_recipe(**kwargs)
    set_author(**kwargs)

    @categories = kwargs[:categories]
  end

  def call
    ActiveRecord::Base.transaction do
      @author.save! if @author.id.nil?
      @author.recipes << @recipe

      @categories.each do |name|
        category = Category.find_or_create_by!(name: name)
        @recipe.categories << category
      end
    end
  end

  private

  def set_recipe(**kwargs)
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
  end

  def set_author(**kwargs)
    @author = Author.find_by(name: kwargs[:author], profile: kwargs[:author_profile])
    return if @author

    @author = Author.new
    @author.name = kwargs[:author]
    @author.profile = kwargs[:author_profile]
  end
end
