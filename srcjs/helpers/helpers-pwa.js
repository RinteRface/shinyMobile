 export const setPWA = (app) => {
    // Create custom install UI
    let installToast = app.toast.create({
      position: 'center',
      text: '<button id="install-button" class="toast-button button color-green">Install</button>',
    });
  
    let deferredPrompt;
    // Handle install event
    $(window).on('beforeinstallprompt', (e) => {
      // Prevent Chrome 67 and earlier from automatically showing the prompt
      e.preventDefault();
      // Stash the event so it can be triggered later.
      deferredPrompt = e.originalEvent;
      // Show install trigger
      installToast.open();
    });
  
    // Installation must be done by a user gesture!
    // close toast whenever a choice is made ... Give time
    // to the toast to be created before event registration.
    app.utils.nextTick(function() {
      $('#install-button').on('click', function() {
        // close install toast
        installToast.close();
        if (!deferredPrompt) {
          // The deferred prompt isn't available.
          return;
        }
        // Show the install prompt.
        deferredPrompt.prompt();
        // Log the result
        deferredPrompt.userChoice.then((result) => {
          console.log('👍', 'userChoice', result);
          // Reset the deferred prompt variable, since
          // prompt() can only be called once.
          deferredPrompt = null;
        });
      });
    }, 500);
  };