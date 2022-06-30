class AddBalconyToRoomTypes < ActiveRecord::Migration[7.0]
  def change
    add_column :room_types, :balconies, :integer
    add_column :room_types, :terraces, :integer
    add_column :room_types, :rooms, :integer
  end
end
