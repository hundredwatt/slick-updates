class CreateUpdateForms < ActiveRecord::Migration[5.0]
  def change
    create_table :update_forms do |t|
      t.string :token
      t.string :name

      t.timestamps

      t.index :token
    end
  end
end
