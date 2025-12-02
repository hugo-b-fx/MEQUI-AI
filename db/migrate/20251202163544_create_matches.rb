class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches do |t|
      t.integer :rider_id
      t.integer :coach_id
      t.string :status

      t.timestamps
    end
  end
end
