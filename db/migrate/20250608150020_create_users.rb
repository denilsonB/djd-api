class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.string :phone
      t.string :user_type

      t.timestamps
    end
  end
end
