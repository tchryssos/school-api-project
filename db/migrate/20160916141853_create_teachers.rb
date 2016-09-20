class CreateTeachers < ActiveRecord::Migration[5.0]
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :subject
      t.string :quote

      t.timestamps
    end
  end
end
