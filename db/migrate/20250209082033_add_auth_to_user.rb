class AddAuthToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :provider_id, :string
    add_column :users, :email, :string
    add_column :users, :tag, :string
  end
end
