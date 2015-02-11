class CreatePighis < ActiveRecord::Migration
  def change
    create_table :pighis do |t|
      t.string name
      t.integer wins
      t.integer losses
  end
end
