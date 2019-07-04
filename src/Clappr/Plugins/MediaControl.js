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
    getSettings: function() {
      // var newSettings = clappr.MediaControl.prototype.getSettings.apply(this);
      var newSettings = { default: [], right: [], left: [] };

      if(config === null) {
        return newSettings;
      }
      if(config.playStop) {
        newSettings.left.push('playstop');
      }
      if(config.position) {
        newSettings.left.push('position');
      }
      if(config.duration) {
        newSettings.left.push('duration');
      }

      if(config.seekBar) {
        newSettings.default.push('seekbar');
      }

      if(config.hdIndicator) {
        newSettings.right.push('hd-indicator');
      }
      if(config.fullScreen) {
        newSettings.right.push('fullscreen');
      }
      if(config.volume) {
        newSettings.right.push('volume');
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
