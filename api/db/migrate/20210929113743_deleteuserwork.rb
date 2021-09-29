class Deleteuserwork < ActiveRecord::Migration[6.0]
  def change
    drop_table :user_works
  end
end
