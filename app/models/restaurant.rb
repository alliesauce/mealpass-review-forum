class Restaurant < ActiveRecord::Base
  has_many :meals, dependent: :destroy
  validates :name, :raw_address, presence: true

  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end
end
