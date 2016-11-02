class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.datetime :start
      t.datetime :end
      t.string :title
      t.text :description
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
