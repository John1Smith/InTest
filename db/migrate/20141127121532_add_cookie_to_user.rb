class AddCookieToUser < ActiveRecord::Migration
  def change
    add_column :users, :cookie, :string
  end
end
