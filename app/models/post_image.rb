class PostImage < ApplicationRecord
  belongs_to :user
  attachment :image
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  acts_as_taggable # acts_as_taggable_on :tagsと同じ意味

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
