class CreateNotificationData < ActiveRecord::Migration[5.1]
  def change
    create_table :notification_data do |t|
      t.string :endpoint
      t.string :p256dh_key
      t.string :auth_key

      t.timestamps
    end
  end
end
