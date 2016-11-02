class AddTotalTimeToEntry < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :total_time, :time
  end
end
