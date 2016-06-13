class Tag < ActiveRecord::Base
  belongs_to :meal
  validates :name, presence: true
end
