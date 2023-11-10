class CreateDonations < ActiveRecord::Migration[7.0]
  def change
    create_table :donations do |t|
      t.integer :price
      t.references :user
      t.timestamps
    end
  end
end
