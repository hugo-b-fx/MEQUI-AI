class ChangeMessageRoleToStringStep1 < ActiveRecord::Migration[7.1]
  def change
    change_column :messages, :role, :string
  end
end
