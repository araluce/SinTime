$ ->
  $("#conversation").animate({ scrollTop: ($('#conversation').prop('scrollHeight')) }, 2000)

  if $('.message-body').length != 0
    setInterval (->
      messages_ids = $('.message-body').map(->
        $(this).data 'id'
      ).get()
      $.ajax Routes.get_messages_path({}),
        type: 'POST'
        data: {
          ids: messages_ids,
          chat_id: $('#conversation').data('id'),
          user_id: $('#datauser').data('userid'),
          admin_id: $('#dataadmin').data('adminid')
        },
        success: () ->
          return
      return
    ), 5000

  $(document).on 'click', '.badge-new-message', (e) ->
    $('.badge-new-message').html('')