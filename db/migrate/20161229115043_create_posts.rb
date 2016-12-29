class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :body
      t.references :owner, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
