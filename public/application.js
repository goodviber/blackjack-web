$(document).ready(function() {
  $(document).on('click', 'input#player_hit', function(){
    $.ajax({
      type: 'POST',
      url: 'player_hit'
    }).done(function(msg) {
      $('#game').replaceWith(msg);
    });
    return false;
  });

  $(document).on('click', 'input#player_stand', function() {
    $.ajax({
      type: 'POST',
      url: 'player_stand'
    }).done(function(msg) {
      $('#game').replaceWith(msg);
    });
    return false;
  });
});