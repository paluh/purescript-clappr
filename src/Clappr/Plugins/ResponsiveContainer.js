"use strict";
/* global exports */


// module Clappr.Plugins.ResponsiveContainer

var clappr = require('clappr');

exports.responsiveContainer = function ResponsiveContainer(core) {
  var playerInfo, that = this;
  clappr.UICorePlugin.call(this, core);

  playerInfo = clappr.PlayerInfo.getInstance(this.options.playerId);
  this.playerWrapper = playerInfo.options.parentElement;

  clappr.$(document).ready(function() {
    that.resize();
  });
};
exports.responsiveContainer.type = clappr.UICorePlugin.type;
exports.responsiveContainer.prototype = Object.create(clappr.UICorePlugin.prototype);
Object.defineProperty(exports.responsiveContainer.prototype, "name", function() { return "responsive_container"; });
exports.responsiveContainer.prototype.bindEvents = function() {
  var that = this;
  clappr.$(window).resize(function() {
    that.resize();
  });
}
exports.responsiveContainer.prototype.resize = function() {
  var width = (this.playerWrapper.clientWidth === 0 ? this.options.width : this.playerWrapper.clientWidth);
  var height = this.options.height / this.options.width * width;
  this.core.resize({ width: width, height: height });
}
