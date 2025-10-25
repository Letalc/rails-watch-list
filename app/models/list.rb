class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks

  has_many :reviews, dependent: :destroy

  has_one_attached :cover

  validates :name, presence: true, uniqueness: true

  validate :acceptable_cover

  def average_rating
    return nil if reviews.empty?
    revies.average(:rating).to_f.round(1)
  end

  private

  def acceptable_cover
    return unless cover.attached?
    if cove.byte_size > 5.megabytes
      errors.add(:cover, "La imagen es demasiado pesada (max 5 MB)")
    end
    acceptable_types = ["image/jpeg", "image/png", "image/webp"]
    unless acceptable_types.include?(cover.content_type)
      errors.add(:cover, "La imagen deber ser JPG, PNG o WEBP")
    end
  end
end
