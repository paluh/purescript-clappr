/* global alert, console, exports, require, setInterval, window */
/* jshint -W097 */

"use strict";

// module Clappr

var clappr = require('clappr');
var hlsjs = require('hls.js');

exports.hlsjsDefaultConfig = hlsjs.defaultConfig;

exports.flasHls = function() {
  if(window._clapprFlasHls === undefined) {
    // it seems that we want to initialize flasHls only once
    // because of it's "global" effects
    window._clapprFlasHls = clappr.FlasHLS;
  }
  return window._clapprFlasHls;
};
exports.hls = clappr.HLS;

exports.clapprImpl = function(options) {
  return new clappr.Player(options);
};

