class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :name, :string
    remove_column :users, :src, :integer
    add_column :users, :name, :string, after: :id
    add_column :users, :src, :string, after: :name
  end
end
