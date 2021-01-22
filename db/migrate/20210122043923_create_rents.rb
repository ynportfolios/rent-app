class CreateRents < ActiveRecord::Migration[5.2]
  def change
    create_table :rents do |t|
      t.string :name
      t.integer :price
      t.string :address
      t.integer :age
      t.text :other

      t.timestamps
    end
  end
end
