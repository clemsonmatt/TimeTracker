class AddCompleteToEntry < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :complete, :boolean
  end
end
