ScrollBot = (selector) ->
  selector.scrollTop selector[0].scrollHeight

MessageHtml = (data, messages) ->
  if data['user_id'] == messages.data('user-id')
    html = '<div class=\'outgoing_msg\'><div class=\'name-sender\'>'+ data['username'] + '</div><div class=\'sent_msg\'><p>' + data['body'] + '</p><span class=\'time_date\'>' + data['created_at'] + '</span></div></div>'
    messages.append html
  else
    html = '<div class=\'incoming_msg\'><div class=\'incoming_msg_img\'>' + '<img src=\'https://ptetutorials.com/images/user-profile.png\'></div>' + '<div class=\'received_msg\'><div class=\'name-receiveder\'>' + data['username'] + '</div><div class=\'received_withd_msg\'><p>' + data['body'] + '</p><span class=\'time_date\'>' + data['created_at'] + '</span></div></div></div>'
    messages.append html

App.chatrooms = App.cable.subscriptions.create "ChatroomsChannel",
  connected: ->
  disconnected: ->
  received: (data) ->
    message = $("#messages")
    if message.length > 0
        MessageHtml(data, message)
        ScrollBot(message)
    else
      $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']").css("font-weight", "bold")
      toastr.success(data.body, 'You got a new message', {timeOut: 5000})
  send_message: (chatroom_id, message) ->
    @perform "send_message", {chatroom_id: chatroom_id, body: message}
