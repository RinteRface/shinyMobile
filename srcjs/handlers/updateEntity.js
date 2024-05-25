import { getAppInstance } from "../init.js";

$(function() {
  const app = getAppInstance();

    // Update configuration (see updateF7Entity)
    Shiny.addCustomMessageHandler('update-entity', function(message) {
    // Recover in which array is stored the given instance.
    // Uniqueness is ensured since HTML id are supposed to be unique.
    let instanceFamily;
    for (const property in app.store.state) {
      for (const e in app.store.state[property]) {
        if (e === message.id) {
          instanceFamily = property;
        }
      }
    }
    let instance = app.store.state[instanceFamily][message.id];
    let oldConfig = instance.params;
    // Destroy old instance
    instance.destroy();
    // Create new instance
    let newInstance = app[instanceFamily].create(app.utils.extend(oldConfig,  message.options));
    // Update app data
    app.store.state[instanceFamily][message.id] = newInstance;
  });
});

