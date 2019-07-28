class AddTabsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tabs, :integer, default: 0
  end
end
