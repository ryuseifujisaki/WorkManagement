class AddColumnUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :grade, :string
    add_column :users, :course, :string
  end
end
