class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    add_index(:users, :email)
  end
end
