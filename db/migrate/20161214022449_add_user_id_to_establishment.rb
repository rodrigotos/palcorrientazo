class AddUserIdToEstablishment < ActiveRecord::Migration[5.0]
  def change
    add_column :establishments, :user_id, :integer
  end
end
