class AddNameToPlayerMatch < ActiveRecord::Migration
  def change
    add_column :player_matches, :name, :string
  end
end
