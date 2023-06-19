class AddAuthorsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :profile

      t.timestamps
    end

    add_column :recipes, :author_id, :int
    add_foreign_key :recipes, :authors
    add_index :authors, :profile, unique: true
  end
end
