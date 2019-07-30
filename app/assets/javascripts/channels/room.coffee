App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    console.log("connected")
    ahoy.track("My second event", {language: "JavaScript"})

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
      $('input').click()
      event.target.value = ""
      event.preventDefault()

scroll_bottom = () ->
  if $('#messages')
      $('#messages').scrollTop($('#messages')[0].scrollHeight)
