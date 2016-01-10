class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :uid

      t.string :current_sign_in_ip
      t.datetime :current_sign_in_at

      t.timestamps
    end
  end
end
