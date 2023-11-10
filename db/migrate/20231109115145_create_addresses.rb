class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :postal_code
      t.integer :prefecture
      t.string :city
      t.string :house_number
      t.string :building_name
      t.references :donation
      t.timestamps
    end
  end
end
