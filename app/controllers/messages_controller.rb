# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :set_chatroom
  before_action :authenticate_user!

  def create
    message = @chatroom.messages.new(message_params)
    message.user = current_user
    message.save
    MessageSaveJob.perform_later(message)
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
