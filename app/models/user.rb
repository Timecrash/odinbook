class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_save :downcase_email
  
  has_many :active_friendships,  class_name:  "Friendship",
                                 foreign_key: "friender_id",
                                 dependent: :destroy
  has_many :passive_friendships, class_name:  "Friendship",
                                 foreign_key: "friended_id",
                                 dependent: :destroy
  has_many :active_friends,  through: :active_friendships,  source: :friended
  has_many :passive_friends, through: :passive_friendships, source: :friender
  
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  def friends
    active_friends + passive_friends
  end
  
  def friend(user)
    self.active_friendships.create(friended_id: user.id)
  end
  
  def unfriend(user)
    friends.find(user.id).destroy
  end
  
  def friends?(user)
    friends.include?(user)
  end
  
  private
  
  def downcase_email
    self.email = email.downcase
  end
end
