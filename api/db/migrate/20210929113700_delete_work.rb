class DeleteWork < ActiveRecord::Migration[6.0]
  def change
    drop_table :works
  end
end
