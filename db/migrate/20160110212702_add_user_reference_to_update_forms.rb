class AddUserReferenceToUpdateForms < ActiveRecord::Migration[5.0]
  def change
    change_table :update_forms do |t|
      t.references :user
    end
  end
end
