# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tasks
  has_many :recurring_tasks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users
  has_many :messages

  enum role: { user: 0, leader: 1, admin: 2 }

  def online?
    !Redis.new.get("user_#{id}_online").nil?
  end
end
