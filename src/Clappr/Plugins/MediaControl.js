/* global exports, require*/
/* jshint -W097 */

"use strict";

var clappr = require('clappr');

exports.mediaControlSetup = function(config) {
  var removeArrayItem = function(arr, item) {
    if(!arr) {
      return;
    }
    var i = arr.indexOf(item);
    if (i >= 0)
      arr.splice(i, 1);
  };
  var dropControl = function(settings, control) {
    removeArrayItem(settings.default, control);
    removeArrayItem(settings.left, control);
    removeArrayItem(settings.right, control);
  };
  return clappr.MediaControl.extend({
    initialize: function() {
      this.settings = {};
    },
    getSettings: function() {
      if(config === null) {
        return;
      }
      var newSettings = clappr.MediaControl.prototype.getSettings.apply(this);
      console.log(newSettings);
      if(!config.fullScreen) {
        dropControl(newSettings, 'fullscreen');
      }
      if(!config.seekBar) {
        dropControl(newSettings, 'seekbar');
      }
      if(!config.hdIndicator) {
        dropControl(newSettings, 'hd-indicator');
      }
      if(!config.volume) {
        dropControl(newSettings, 'volume');
      }
      if(!config.playStop) {
        dropControl(newSettings, 'playstop');
      }
      return newSettings;
    },
    toggleFullscreen: function() {
      if(config === null || !config.fullScreen) {
        return;
      }
      clappr.MediaControl.prototype.toggleFullscreen.apply(this);
    }
  });
};
