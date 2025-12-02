class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :integer
    add_column :users, :name, :string
    add_column :users, :location, :string
    add_column :users, :bio, :text
    add_column :users, :price_per_hour, :integer
    add_column :users, :specialities, :text
    add_column :users, :level, :string
    add_column :users, :objective, :text
    add_column :users, :photos, :text
  end
end
