class CreateMicroposts < ActiveRecord::Migration[6.0]
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    # multiple key index, which means that Active Record uses both keys at the same time.
    add_index :microposts, [:user_id, :created_at]
  end
end
