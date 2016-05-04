App.invite_notification = App.cable.subscriptions.create "InviteNotificationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $("#notification-container div#flash_notice").html(data.message)
    $("#notification-container").show()
