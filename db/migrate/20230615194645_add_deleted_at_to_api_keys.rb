class AddDeletedAtToApiKeys < ActiveRecord::Migration[7.0]
  def change
    add_column :api_keys, :deleted_at, :datetime
  end
end
