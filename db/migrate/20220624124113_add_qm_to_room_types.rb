class AddQmToRoomTypes < ActiveRecord::Migration[7.0]
  def change
    add_column :room_types, :qm, :float
  end
end
