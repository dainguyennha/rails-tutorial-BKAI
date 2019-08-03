document.addEventListener 'turbolinks:load', ->
  room_id = $('#messages').data('room_id')
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: room_id },
    connected: ->
      console.log("connected")

    disconnected: ->
      console.log('disconnect')

    received: (data) ->
      $('#messages').append(data)
      scroll_bottom()

    speak: (message) ->
      @perform 'speak', message:message

$(document).on 'turbolinks:load', ->
  submit_message()
  scroll_bottom()

submit_message = () ->
  $('#message_content').on 'keydown', (event) ->
    if event.keyCode is 13
      $('#new_message').submit()
      event.target.value = ""
      event.preventDefault()

scroll_bottom = () ->
  if $('#messages')
    $('#messages').scrollTop($('#messages')[0].scrollHeight)
