class CreateLeaderboards < ActiveRecord::Migration
  def change
    create_table :leaderboards do |t|
      t.string :name
      t.integer :wins
      t.integer :losses
    end
  end
end
