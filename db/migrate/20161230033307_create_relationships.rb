class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.references :subscriber, foreign_key: { to_table: :users }
      t.references :publisher, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
