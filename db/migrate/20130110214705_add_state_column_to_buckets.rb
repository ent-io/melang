class AddStateColumnToBuckets < ActiveRecord::Migration
  def change
    add_column :buckets, :state, :integer, :default => 0, :null => false
  end
end
