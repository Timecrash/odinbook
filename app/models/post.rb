class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes,    dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_attached_file :image, styles: { medium: "400x400>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  
  default_scope -> { order(created_at: :desc) }
  validates :text, presence: true
  validates :user_id, presence: true
end
