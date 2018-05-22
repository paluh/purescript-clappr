/* global exports */
"use strict";

// module Clappr.Plugins.Streamroot.js

var clappr = require('clappr');

exports.streamrootHlsjsImpl = function(streamrootKey) {
  return function(onError, onSuccess) {
    window.clappr = clappr;
    window.Clappr = clappr;
    var script = document.createElement('script');
    script.onload = function (v) {
      onSuccess(HlsDnaPlugin);
    };
    script.src = "//cdn.streamroot.io/clappr-hls-dna-plugin/1/stable/clappr-hls-dna-plugin.js#streamrootKey=" + streamrootKey;
    document.head.appendChild(script);
    return function(cancelError, cancelerError, cancelerSuccess) {
      cancelError();
    };
  };
}

exports.flashHls = clappr.FlasHLS;
exports.hls = clappr.HLS;
