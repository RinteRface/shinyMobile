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
    app.notification.create({
      icon: '<i class="icon f7-icons">bolt_fill</i>',
      title: 'Disconnected',
      text: '<button onclick="Shiny.shinyapp.reconnect();" class="button">Reconnect <i class="icon f7-icons">arrow_2_circlepath</i></button>',
      on: {
        click: function (notification) {
          notification.close();
        },
      }
    }).open();
  });
});
