class CreateApiKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :api_keys do |t|
      t.integer :user_id, null: false
      t.string :token_digest, null: false
      t.timestamps
    end

    add_foreign_key :api_keys, :users
    add_index :api_keys, :token_digest, unique: true
  end
end
