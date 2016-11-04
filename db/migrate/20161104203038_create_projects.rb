class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.boolean :private
      t.string :status

      t.timestamps
    end
  end
end
