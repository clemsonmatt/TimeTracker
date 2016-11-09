class ChangeTotalTimeDefaultInEntries < ActiveRecord::Migration[5.0]
  def change
    change_column_default :entries, :total_time, from: "", to: nil
  end
end
