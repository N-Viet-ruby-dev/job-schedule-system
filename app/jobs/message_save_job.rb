# frozen_string_literal: true

class MessageSaveJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "chatrooms:#{message.chatroom_id}",
                                 user_id: message.user.id,
                                 username: message.user.username,
                                 body: message.body,
                                 chatroom_id: message.chatroom_id,
                                 created_at: message.created_at.localtime.strftime("%I:%M %p")
  end
end
