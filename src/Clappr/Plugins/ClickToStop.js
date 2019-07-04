var clappr = require('clappr');

exports.clickToStop = (function() {
  return clappr.ContainerPlugin.extend({
    name: function() { return 'click_to_stop'; },
    constructor: function(container) {
      clappr.ContainerPlugin.prototype.constructor.apply(this, container);
    },
    bindEvents: function() {
      this.listenTo(this.container, clappr.Events.CONTAINER_CLICK, this.click);
      this.listenTo(this.container, clappr.Events.CONTAINER_SETTINGSUPDATE, this.settingsUpdate);
    },
    click: function() {
      if (this.container.isPlaying()) {
        this.container.stop();
      } else {
        this.container.play();
      }
    },
    settingsUpdate: function() {
      this.container.$el.addClass('pointer-enabled');
    }
  });
})();
