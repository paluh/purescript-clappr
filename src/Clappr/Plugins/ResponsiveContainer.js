"use strict";
/* global exports */
// module Clappr.Plugins.ResponsiveContainer
var clappr = require('clappr');

exports.responsiveContainer = function ResponsiveContainer(core) {
  var playerInfo, that = this;
  clappr.UICorePlugin.call(this, core);

  playerInfo = clappr.PlayerInfo.getInstance(this.options.playerId);
  this.playerWrapper = playerInfo.options.parentElement;

  this.height = this.options.height;
  this.width = this.options.width;
  this.resize();
};
exports.responsiveContainer.type = clappr.UICorePlugin.type;
exports.responsiveContainer.prototype = Object.create(clappr.UICorePlugin.prototype);
Object.defineProperty(exports.responsiveContainer.prototype, "name", function() { return "responsive_container"; });
exports.responsiveContainer.prototype.bindEvents = function() {
  var that = this;
  this.listenTo(this.core.mediaControl, clappr.Events.MEDIACONTROL_CONTAINERCHANGED, function() {
    that.resize();
  });
  // I'm really tired of searching for appropriate event...
  clappr.Mediator.on(this.options.playerId + ":" + clappr.Events.PLAYER_READY, function() {
    that.resize();
  });
  // ... so I'm using this hacky strategy.
  this.listenTo(this.core.mediaControl, clappr.Events.MEDIACONTROL_CONTAINERCHANGED, function() {
    that.resize();
  });
  clappr.$(window).resize(function() {
    that.resize();
  });
};

exports.responsiveContainer.prototype.resize = function() {
  var width, height;
  if(this.playerWrapper !== undefined && this.playerWrapper.clientWidth > 0) {
    width = this.playerWrapper.clientWidth;
    height = this.height / this.width * width;
    this.core.resize({ width: width, height: height });
  };
};
