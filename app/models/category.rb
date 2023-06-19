class Category < ApplicationRecord
  has_many :recipes, through: categories_recipes
end
