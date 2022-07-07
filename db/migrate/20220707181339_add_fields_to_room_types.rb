class AddFieldsToRoomTypes < ActiveRecord::Migration[7.0]
  def change
    add_column :room_types, :details, :text
    add_column :room_types, :kitchen, :text
    add_column :room_types, :laundry, :text
    add_column :room_types, :bathroom, :text
    add_column :room_types, :entertainment, :text
    add_column :room_types, :communication, :text
    add_column :room_types, :other, :text
    add_column :room_type_translations, :details, :text
    add_column :room_type_translations, :kitchen, :text
    add_column :room_type_translations, :laundry, :text
    add_column :room_type_translations, :bathroom, :text
    add_column :room_type_translations, :entertainment, :text
    add_column :room_type_translations, :communication, :text
    add_column :room_type_translations, :other, :text
  end
end
