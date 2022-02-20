class CreateParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :participants do |t|
      t.references :game, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true
      t.integer :score
      t.integer :status

      t.timestamps
    end
  end
end
