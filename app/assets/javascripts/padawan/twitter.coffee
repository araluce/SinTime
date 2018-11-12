$ ->

  load_tweeter = () ->
    $(document).on 'change', '#tweeter_select', (evt) ->
      tweeter_id = $(this).val()
      unless tweeter_id == '0'
        console.log tweeter_id

  load_tweeter()