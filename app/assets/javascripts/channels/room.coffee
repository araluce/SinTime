App.room = App.cable.subscriptions.create{
    channel: 'RoomChannel'
  },
  connected: ->
    # Called when the subscription is ready for use on the server
    alert("Connected")
  disconnected: ->
    # Called when the subscription has been terminated by the server
    alert("Disconnected")

  received: (data) ->
    alert("You have a new mention")
    console.log 'Hi'

    $('#comment').val('')
    $('.bottom-tag').removeAttr('id')
    unless data.message.blank?
      $('#conversation').append data.message

    $(document).on 'turbolinks:load', ->
      submit_message()
      scroll_bottom()

    submit_message = () ->
      $('#message_content').on 'keydown', (event) ->
        if event.keyCode is 13 && !event.shiftKey
          $('input').click()
          event.target.value = ""
          event.preventDefault()

    scroll_bottom = () ->
      $('#conversation').scrollTop($('#conversation')[0].scrollHeight)