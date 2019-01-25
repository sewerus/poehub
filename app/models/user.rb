class User < ApplicationRecord
  has_many :poems, dependent: :destroy
  has_many :lines, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :favourite_lines, through: :likes, source: :line, dependent: :destroy
  has_many :subscribes, dependent: :destroy
  has_many :subscribed_poems, through: :subscribes, source: :poem, dependent: :destroy

  after_create :set_default_role

  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  private
  def set_default_role
    self.add_role(:writer)
    self.add_role(:reader)
  end
end
