class AddResetpasswordToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :password_reset_digest, :string
    add_column :users, :reset_password_at, :datetime
  end
end
