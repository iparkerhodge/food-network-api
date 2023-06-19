class Recipe < ApplicationRecord
  has_many :categories, through: categories_recipes
end
