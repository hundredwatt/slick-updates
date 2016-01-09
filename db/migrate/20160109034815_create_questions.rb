class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.references :update_form, index: true

      t.text :text

      t.timestamps
    end
  end
end
