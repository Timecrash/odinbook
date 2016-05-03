class Post < ActiveRecord::Base
  belongs_to :user
  
  validates :text, presence: true
  validates :user_id, presence: true
end
