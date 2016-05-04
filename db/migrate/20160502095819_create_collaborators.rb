class CreateCollaborators < ActiveRecord::Migration[5.0]
  def change
    create_table :collaborators do |t|
      t.integer :user_id
      t.integer :update_form_id

      t.timestamps
    end
  end
end
