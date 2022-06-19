class AddTelephonePassToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :telephone_pass, :string, after: :src
  end
end
