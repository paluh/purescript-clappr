/* global exports */
"use strict";

// module Clappr

var clappr = require('clappr');

exports.clapprImpl = function(options) {
  return new clappr.Player(options);
};
