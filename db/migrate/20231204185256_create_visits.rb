class CreateVisits < ActiveRecord::Migration[7.1]
  def change
    create_table :visits do |t|
      t.string :ip
      t.datetime :date
      t.references :link, null: false, foreign_key: true

      t.timestamps
    end

    add_index :visits, [:ip, :date], unique: true
  end
end
