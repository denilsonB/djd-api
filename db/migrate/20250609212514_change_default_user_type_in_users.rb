class ChangeDefaultUserTypeInUsers < ActiveRecord::Migration[5.1]
  def change
    change_column_default :users, :user_type, 'client'
  end
end
