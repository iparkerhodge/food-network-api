class UpdateRecipeTimes < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :active_time
    add_column :recipes, :time_descriptions, :string, array: true, default: []
  end
end
