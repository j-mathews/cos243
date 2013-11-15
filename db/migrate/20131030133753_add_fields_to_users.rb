class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contest_creator, :boolean, default: false
    add_column :users, :banned, :boolean, default: false
    add_column :users, :chat_url, :string
  end
end
