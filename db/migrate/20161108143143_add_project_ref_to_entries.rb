class AddProjectRefToEntries < ActiveRecord::Migration[5.0]
  def change
    add_reference :entries, :project, foreign_key: true
  end
end
