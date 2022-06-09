class CreateRoomTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :room_types do |t|
      t.integer :account_id
      t.string :name
      t.string :description
      t.json :amenities
      t.integer :position, default: 0
    end
  end
end
