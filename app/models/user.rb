class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  has_many :post_images
  has_many :post_comments
  has_many :favorites, dependent: :destroy
  attachment :profile_image
  # 以下follow機能関連
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  # 2行目　through: :relationshipsで中間テーブルを明示、source: :followで、relationshipsテーブルのfollowingsモデルへアクセス
  # 3行目　reverse_of_relationships　followingsテーブルからフォローしている人のデータをとってくる
  # 4行目　userテーブルから自分をフォローしているuserをとってくる
  def follow(other_user) # フォローしようとしているother_userが自分ではないかを検証
    unless self == other_user
      relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user) # フォローの重複を防ぐ
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user) # フォローしているUserを取得し、other_userが含まれていないか確認
    followings.include?(other_user)
  end
end
