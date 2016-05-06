class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :text, presence: true
  validates :user_id, presence: true
end
