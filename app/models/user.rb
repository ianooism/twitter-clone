class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable
  
  # user as owner has many posts
  has_many :posts, foreign_key: :owner_id, dependent: :destroy
  
  # user as subscriber has many following relationships
  # user.following_relationships returns set of relationships that user follows
  has_many :following_relationships, class_name: :Relationship,
           foreign_key: :subscriber_id, dependent: :destroy
  
  # user.following returns set of publishers that user follows
  has_many :following, through: :following_relationships, source: :publisher
  
  # user as publisher has many follower relationships
  # user.follower_relationships returns set of relationships that follows user
  has_many :follower_relationships, class_name: :Relationship,
           foreign_key: :publisher_id, dependent: :destroy
  
  # user.following returns set of subscribers that follows user
  has_many :followers, through: :follower_relationships, source: :subscriber
  
  def follow(publisher)
    following << publisher
  end
  
  def unfollow(publisher)
    following.delete(publisher)
  end
  
  def following?(publisher)
    following.include?(publisher)
  end
  
  def not_following
    User.all - [self] - following
  end
  
  def explore_posts
    not_following.map(&:posts).flatten
  end
  
  def home_posts
    posts + following.map(&:posts).flatten
  end
end
