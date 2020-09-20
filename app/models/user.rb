class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: { maximum: 50 }

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :follower, class_name:"Relationship", foreign_key:"follower_id", dependent: :destroy #フォローの取得
  has_many :followed, class_name:"Relationship", foreign_key:"followed_id",dependent: :destroy  #フォロワーの取得
  has_many :following_user,through: :follower, source: :followed  #自分がフォローしているユーザーの取得
  has_many :follower_user, through: :followed, source: :follower#自分をフォローしているユーザーの取得
  #すでにフォロー済みであればtrueを返す
  def following?(user)
    following_user.include?(user)
  end
  #フォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  #フォローを解除する
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
end
