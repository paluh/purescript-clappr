/* global alert, console, clearInterval, exports, require, setInterval */
/* jshint -W097 */

"use strict";

var clappr = require('clappr');

exports.replayOnBuffering = clappr.ContainerPlugin.extend({
  bindEvents: function() {
    this.listenTo(this.container, clappr.Events.CONTAINER_STATE_BUFFERING, this.onBuffering);
    this.listenTo(this.container, clappr.Events.CONTAINER_STATE_BUFFERFULL, this.onBufferfull);
    this.listenTo(this.container, clappr.Events.CONTAINER_STOP, this.onStop);
    this.bufferingMonitor = null;
    //  This option can't be null/undefined when you use PureScript API.
    //  Falling back to default value to backup pure JavaScript usage.
    this.bufferingTimeout = this.options.replayBufferingTimeout || 60;
  },
  _clearMonitor: function() {
    // I'm not sure how to debug print from plugins.
    // How should I perform something like this:
    // clappr.Log.debug("Resetting buffering checker...");
    // So I can stop uncommenting this when I want to debug:
    // console.log("Resetting buffering checker...");
    if(this.bufferingMonitor !== null) {
      clearInterval(this.bufferingMonitor);
      this.bufferingMonitor = null;
    }
  },
  onBufferfull: function() {
    this._clearMonitor();
  },
  onBuffering: function() {
    var bufTime = 0;
    var that = this;
    this._clearMonitor();
    // clappr.Log.debug("Starting buffering checker...");
    this.bufferingMonitor = setInterval(function () {
      bufTime += 1;
      // clappr.Log.debug("Buffering checker time:" + bufTime);
      // console.log("Buffering checker time:" + bufTime);
      if (bufTime >= that.bufferingTimeout) {
        that._clearMonitor();
        that.container.stop();
        that.container.play();
      }
    }, 1000);
  },
  onStop: function() {
    this._clearMonitor();
  }
});
