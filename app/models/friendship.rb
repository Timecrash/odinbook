class Friendship < ActiveRecord::Base
  belongs_to :friender, class_name: "User"
  belongs_to :friended, class_name: "User"
  validates :friender_id, presence: true
  validates :friended_id, presence: true

  def accept_friendship
    update_attribute(:accepted, true)
  end
end