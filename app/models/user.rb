class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  enum gender: %i[female male custom]

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true
  validates :date_of_birth, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy


has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, -> { where(confirmed: true) }, class_name: 'Friendship',
                                                                foreign_key: :friend_id, dependent: :destroy
  has_many :confirmed_friendships, -> { where(confirmed: true) }, class_name: 'Friendship',
                                                                  foreign_key: :user_id, dependent: :destroy
  has_many :confirmed_friends, through: :confirmed_friendships, source: :friend
  has_many :confirmed_inverse_friends, through: :inverse_friendships, source: :user
  has_many :pending_friendships, -> { where(confirmed: nil) }, class_name: 'Friendship',
                                                               foreign_key: :user_id, dependent: :destroy
  has_many :pending_inverse_friendships, -> { where(confirmed: nil) }, class_name: 'Friendship',
                                                                       foreign_key: :friend_id, dependent: :destroy
  has_many :confirmed_friends_posts, through: :confirmed_friends, source: :posts
  has_many :conirmed_inverse_friends_posts, through: :confirmed_inverse_friends, source: :posts

 

  def full_name
    return "#{first_name} #{last_name}".strip if first_name || last_name

    'Annonymous'
  end

  def friends
    confirmed_friends + confirmed_inverse_friends
  end

  def pending_friends
    pending_friendships.map(&:friend)
  end

  def friend_requests
    pending_inverse_friendships.map(&:user)
  end

  def friend?(user)
    friends.include?(user)
  end

  def sent_request?(user)
    pending_friends.include?(user)
  end

  def cancel_friend_request(user)
    friendship = friendships.find { |f| f.friend_id == user.id }
    friendship.destroy
  end

  def reject_friend(user)
    friendship = pending_inverse_friendships.find { |f| f.user == user }
    friendship.destroy
  end

  def mutual_friends(user)
    friends & user.friends unless user.id == id
  end

end
