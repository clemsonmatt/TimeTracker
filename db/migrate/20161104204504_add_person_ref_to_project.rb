class AddPersonRefToProject < ActiveRecord::Migration[5.0]
  def change
    add_reference :projects, :person, foreign_key: true
  end
end
