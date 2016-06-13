class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :meal
  has_many :comments, dependent: :destroy
end

