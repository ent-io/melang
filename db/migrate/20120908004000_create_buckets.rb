class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.string  :name, :limit => 255, :null => false
      t.integer :app_id, :null => false

      t.timestamps
    end
    add_index(:buckets, :name, :unique => true)
    add_index(:buckets, :app_id, :unique => true)
  end
end
