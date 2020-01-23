class FixOrder < ActiveRecord::Migration[6.0]
  def down
    remove_column :orders, :shipping_type_id
  end

  def up
    add_column :orders, :shipping_type_id, :integer 

  end
end
