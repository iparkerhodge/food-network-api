class AddSourceToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :source, :string, null: false
  end
end
