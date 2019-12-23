class AddUniqueToUsersName < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :username, :string, unique: true
  end
end
