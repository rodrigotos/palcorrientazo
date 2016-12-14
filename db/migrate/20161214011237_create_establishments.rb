class CreateEstablishments < ActiveRecord::Migration[5.0]
  def change
    create_table :establishments do |t|
      t.string :name
      t.string :zone
      t.boolean :state
      t.float :longitude
      t.float :latitude
      t.text :description
      t.decimal :price
      t.decimal :avg_qualification
      t.integer :like_count
      t.string :category

      t.timestamps
    end
  end
end
