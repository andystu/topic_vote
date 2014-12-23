class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :topic_id

      t.timestamps
    end
    add_index :votes, :topic_id
  end
end
