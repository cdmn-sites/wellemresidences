class ChangeQmToString < ActiveRecord::Migration[7.0]
  def change
    change_column :room_types, :qm, :string
  end
end
