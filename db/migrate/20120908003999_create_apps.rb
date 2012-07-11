class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name, :limit => 63, :null => false
      t.string :git_url, :null => false

      t.timestamps
    end
    add_index :apps, :name, :unique => true
  end
end
