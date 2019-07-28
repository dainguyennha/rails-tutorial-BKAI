App.appearance = App.cable.subscriptions.create "AppearanceChannel",
  # Called when the subscription is ready for use on the server.
  connected: ->
    console.log('appear connected')
  # Called when the WebSocket connection is closed.
  disconnected: ->
    console.log('appear disconnected') 
  # Called when the subscription is rejected by the server.
  rejected: ->
    console.log("rejected")

  received: (data) ->
    user = JSON.parse(data)
    if user.online is true
      $(userImgIdConstructor(user)).attr('class', 'active')
    
    if user.online is false
      $(userImgIdConstructor(user)).attr('class', 'inactive')
    
userImgIdConstructor = (user) -> "#" + user.id + "-status"
