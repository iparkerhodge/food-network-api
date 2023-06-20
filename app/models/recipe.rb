class Recipe < ApplicationRecord
  has_many :tags, foreign_key: :recipe_id
  has_many :categories, through: :tags
  belongs_to :author
end
