class CreateQualifications < ActiveRecord::Migration[5.0]
  def change
    create_table :qualifications do |t|
      t.integer :user_id
      t.integer :establishment_id
      t.integer :qualification
      t.text :comment

      t.timestamps
    end
  end
end
