$(document).ready ->
  $("#new_message").on "keypress", (e) ->
    if e.keyCode == 13
      e.preventDefault()
      $(this).submit()

  $("#new_message").on "submit", (e) ->
    e.preventDefault()
    chatroom_id = $("#messages").data("chatroom-id")
    body        = $("#message_body")
    App.chatrooms.send_message(chatroom_id, body.val())
    body.val("")
