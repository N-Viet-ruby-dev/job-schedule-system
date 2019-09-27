# frozen_string_literal: true

class ChatroomUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom

  def create
    @chatroom_user = ChatroomUser.find_or_create_by(user_id: current_user.id, chatroom_id: @chatroom.id)
    redirect_to @chatroom
  end

  def destroy
    @chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).destroy_all
    redirect_to chatrooms_path
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end
end
