class AddTypeToContests < ActiveRecord::Migration
  def change
    add_column :contests, :type, :string
  end
end
