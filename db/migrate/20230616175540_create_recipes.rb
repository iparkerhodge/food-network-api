class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :level
      t.string :total_time
      t.string :active_time
      t.string :servings
      t.string :directions, array: true, default: []
      t.string :image_url

      t.timestamps
    end
  end
end
