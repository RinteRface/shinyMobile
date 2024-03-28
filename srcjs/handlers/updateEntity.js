import { getAppInstance } from "../init.js";

$(function() {
  const app = getAppInstance();

    // Update configuration (see updateF7Entity)
    Shiny.addCustomMessageHandler('update-entity', function(message) {
    // Recover in which array is stored the given instance.
    // Uniqueness is ensured since HTML id are supposed to be unique.
    var instanceFamily;
    for (const property in app.store.state) {
      for (const e in app.store.state[property]) {
        if (e === message.id) {
          instanceFamily = property;
        }
      }
    }

    var oldInstance = app.store.state[instanceFamily][message.id];
    var oldConfig = oldInstance.params;
    var newConfig = app.utils.extend(oldConfig,  message.options);

    // Destroy old instance
    oldInstance.destroy();
    // Create new config
    var newInstance = app[instanceFamily].create(newConfig);
    // Update app data
    app.store.state[instanceFamily][message.id] = newInstance;
  });
});

