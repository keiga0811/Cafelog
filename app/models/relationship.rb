class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User' # Userクラスを参照するように

  validates :user_id, presence: true
  validates :follow_id, presence: true
end
