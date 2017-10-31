class Page < ApplicationRecord
  has_many :elements, dependent: :destroy

  validates :url, presence: true
  validates :url, uniqueness: true
end
