class Meal < ActiveRecord::Base
  belongs_to :restaurant
  has_many :tags, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
  validates :restaurant_id, presence: true
end
