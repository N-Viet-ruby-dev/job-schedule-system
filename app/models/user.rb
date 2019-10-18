# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :omniauthable

  has_many :tasks, dependent: :destroy
  has_many :recurring_tasks, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :workings, dependent: :destroy
  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users
  has_many :messages
  has_many :suggests, dependent: :destroy
  has_many :notifications, dependent: :destroy

  enum permission: { close: 0, open: 1 }
  enum role: { user: 0, leader: 1, admin: 2 }
  scope :newest, -> { order created_at: :desc }

  validates_presence_of :password_confirmation
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.image = auth.info.image_48
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name
      user.role = auth.info.is_admin? ? :admin : auth.info.is_owner? ? :leader : :user
    end
  end

  def self.search_user(search_user)
    where("lower(users.username) LIKE :search_user", search_user: "%#{search_user}%").distinct
  end
end
