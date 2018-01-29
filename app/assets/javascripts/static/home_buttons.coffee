$ ->
  $('.diamond').height($('.diamond').width());

  $(window).resize ->
    $('.diamond').height($('.diamond').width());