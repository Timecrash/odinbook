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
  has_many :posts,           dependent: :destroy
  
  validates :first_name, presence: true
  validates :last_name,  presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
  #Add avatar code here, via paperclip.
  
  def name
    "#{first_name} #{last_name}"
  end
  
  #To refactor: add posts for friends.
  def timeline
    self.posts
  end
  
  def friends
    active_friends.where("accepted = ?", true) + passive_friends.where("accepted = ?", true)
  end
  
  def friend(recipient)
    active_friendships.create(friended_id: recipient.id)
  end
  
  def unfriend(recipient)
    if active = active_friendships.find_by(friended_id: recipient.id)
      active.destroy
    elsif passive = passive_friendships.find_by(friender_id: recipient.id)
      passive.destroy
    end
  end
  
  def accept_friendship(requester)
    passive_friendships.find_by(friender_id: requester.id).accept
  end
  
  def friends?(user)
    friends.include?(user)
  end
  
  def friend_requests
    passive_friendships.where("accepted = ?", false)
  end
  
  private
  
  def downcase_email
    self.email = email.downcase
  end
end
