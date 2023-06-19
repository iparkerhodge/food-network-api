class CreateJoinTableRecipesCategories < ActiveRecord::Migration[7.0]
  def change
    create_join_table :recipes, :categories do |t|
      t.index %i[recipe_id category_id]
      t.index %i[category_id recipe_id]
    end
  end
end
