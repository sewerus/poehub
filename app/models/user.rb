class User < ApplicationRecord
  has_many :poems
  has_many :lines
  has_many :likes
  has_many :favourite_lines, through: :likes, source: :line
  has_many :subscribes
  has_many :subscribed_poems, through: :subscribes, source: :poem

  rolify
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
end
