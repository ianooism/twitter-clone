class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # owner is a user that has posts
  has_many :posts, foreign_key: :owner_id, dependent: :destroy
  
  # subscriber is a user that has following relationships
  has_many :following_relationships, class_name: :Relationship,
           foreign_key: :subscriber_id, dependent: :destroy
  # user.following returns collection of publishers
  has_many :following, through: :following_relationships,
           source: :publisher
  
  # publisher is a user that has follower relationships
  has_many :follower_relationships, class_name: :Relationship,
           foreign_key: :publisher_id, dependent: :destroy
  # user.followers returns collection of subscribers
  has_many :followers, through: :follower_relationships,
           source: :subscriber
  
  def home_feed_posts
    self.following.map(&:posts).flatten + self.posts
  end
  
  def not_following
    User.all - [self] - self.following
  end
  
end
