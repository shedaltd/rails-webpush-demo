class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :notif_id
      t.string :name
      t.integer :auth_key

      t.timestamps
    end
  end
end
