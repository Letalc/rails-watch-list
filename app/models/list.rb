class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks

  has_many :reviews, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def average_rating
    return nil if reviews.empty?
    reviews.average(:rating).to_f.round(1)
  end
end
