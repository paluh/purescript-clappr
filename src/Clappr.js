/* global exports */
"use strict";

// module Clappr

var clappr = require('clappr');
var hlsjs = require('hls.js');

exports.hlsjsDefaultConfig = hlsjs.defaultConfig;

exports.flasHls = clappr.FlasHLS;
exports.hls = clappr.HLS;

exports.clapprImpl = function(options) {
  options.hideMediaControl = true;
  return new clappr.Player(options);
};
