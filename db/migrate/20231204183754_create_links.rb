class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :url, null: false
      t.string :slug, null: false
      t.string :link_category, null: false
      t.string :password
      t.datetime :expiration_date
      t.integer :access_count
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :links, :url, unique: true
    add_index :links, :slug, unique: true
  end
end
