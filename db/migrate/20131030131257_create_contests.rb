class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.datetime :deadline
      t.datetime :start
      t.string :contest_name
      t.string :contest_type
      t.references :user, index: true
      t.references :referee, index: true
      t.text :description

      t.timestamps
    end
  end
end
