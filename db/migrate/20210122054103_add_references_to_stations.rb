class AddReferencesToStations < ActiveRecord::Migration[5.2]
  def change
    add_reference :stations, :rent, foreign_key: true
  end
end
