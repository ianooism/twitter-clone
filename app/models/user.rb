class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # user.posts
  has_many :posts, foreign_key: :owner_id, dependent: :destroy
  
  # user.following
  # user that follows others = subscriber
  has_many :subscriber_relationships, class_name: :Relationship,
           foreign_key: :subscriber_id, dependent: :destroy
  has_many :following, through: :subscriber_relationships,
           source: :publisher
  
  # user.followers
  # user that has followers = publisher
  has_many :publisher_relationships, class_name: :Relationship,
           foreign_key: :publisher_id, dependent: :destroy
  has_many :followers, through: :publisher_relationships,
           source: :subscriber
  
end
