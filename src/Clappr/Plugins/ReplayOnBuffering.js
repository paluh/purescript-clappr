/* global alert, console, clearInterval, exports, require, setInterval */
/* jshint -W097 */

"use strict";

var clappr = require('clappr');

exports.replayOnBuffering = clappr.ContainerPlugin.extend({
  bindEvents: function() {
    this.listenTo(this.container, clappr.Events.CONTAINER_STATE_BUFFERING, this.onBuffering);
    this.listenTo(this.container, clappr.Events.CONTAINER_STATE_BUFFERFULL, this.onBufferfull);
    this.listenTo(this.container, clappr.Events.CONTAINER_STOP, this.onStop);
    this.bufferingTimeout = null;
  },
  _clearChecker: function() {
    // I'm not sure how to debug print from plugins:
    // clappr.Log.debug("Resetting buffering checker...");
    if(this.bufferingTimeout !== null) {
      clearInterval(this.bufferingTimeout);
      this.bufferingTimeout = null;
    }
  },
  onBufferfull: function() {
    this._clearChecker();
  },
  onBuffering: function() {
    var bufTime = 0;
    var that = this;
    this._clearChecker();
    // clappr.Log.debug("Starting buffering checker...");
    this.bufferingTimeout = setInterval(function () {
      bufTime += 1;
      // clappr.Log.debug("Buffering checker time:" + bufTime);
      if (bufTime >= that.options.replayBufferingTimeout) {
        that._clearChecker();
        that.container.stop();
        that.container.play();
      }
    }, 1000);
  },
  onStop: function() {
    this._clearChecker();
  }
});
