$(function() {
  // crash the socket
  $('#btn1').on('click', function(event) {
    Shiny.shinyapp.$sendMsg('plop');
  });

  // show reconnect notification
  $(document).on('shiny:disconnected', function(event) {
    // remove shiny server stuff
    $('#ss-connect-dialog').hide();
    $('#ss-overlay').hide();
    // use Framework7 internal tools
    var reconnectToast = app.toast.create({
      icon: '<i class="icon f7-icons">bolt_fill</i>',
      position: 'center',
      text: 'Oups... disconnected </br> </br> <div class="row"><button onclick="Shiny.shinyapp.reconnect();" class="toast-button button color-green col">Reconnect</button><button onclick="location.reload();" class="toast-button button color-red col">Reload</button></div>',
    }).open();

    // close toast whenever a choice is made ...
    $('.toast-button').on('click', function() {
      reconnectToast.close();
    });
  });
});
