class Category < ApplicationRecord
  has_many :tags, foreign_key: :category_id
  has_many :recipes, through: :tags
end
