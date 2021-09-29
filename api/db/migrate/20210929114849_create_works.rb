class CreateWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :works do |t|
      t.string :name
      t.string :limit
      t.string :day
      t.string :where
      t.string :money
      t.string :carfare
      t.string :content
      t.string :cloth
      t.string :belonging
      t.string :other

      t.timestamps
    end
  end
end
