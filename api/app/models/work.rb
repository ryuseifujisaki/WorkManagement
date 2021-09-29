class Work < ApplicationRecord
  has_many :user_works
  has_many :users, through: :user_works
end
