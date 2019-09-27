# frozen_string_literal: true

class ChatroomUser < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user
end
