class ChangeJoinTable < ActiveRecord::Migration[7.0]
  def change
    rename_table :categories_recipes, :tags
  end
end
