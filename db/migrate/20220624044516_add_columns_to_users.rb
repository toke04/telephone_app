class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :sip_regist_flag, :boolean, default: false, null: false, after: :telephone_pass
  end
end
