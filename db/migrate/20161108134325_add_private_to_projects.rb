class AddPrivateToProjects < ActiveRecord::Migration[5.0]
  def change
    change_column_default :projects, :private, from: nil, to: false
  end
end
