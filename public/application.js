$(document).ready(function() {
  $(document).on('click', 'button#player_hit', function(){
    $.ajax({
      type: 'GET',
      url: 'player_hit'
    }).done(function(msg) {
      $('#game').replaceWith(msg);
    });
    $.ajax({
      type: 'GET',
      url: 'update_navbar'
    }).done(function(nav) {
      $('.navbar').replaceWith('nav .navbar')
    });
    return false;
  });

  $(document).on('click', 'button#player_stand', function() {
    $.ajax({
      type: 'GET',
      url: 'player_stand'
    }).done(function(msg) {
      $('#game').replaceWith(msg);
    });
    $.ajax({
      type: 'GET',
      url: 'update_navbar'
    }).done(function(cash) {
      $('#cash').replaceWith(cash)
    });
    return false;
  });
});