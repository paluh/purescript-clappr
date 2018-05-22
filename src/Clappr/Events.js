/* global exports */
"use strict";

// module Clappr.Events

var Clappr = require('clappr');

exports.onContainerBitrateImpl = function(clappr, callback) {
  return clappr.on(Clappr.Events.CONTAINER_BITRATE, callback);
};

exports.onContainerErrorImpl = function(clappr, callback) {
  return clappr.on(Clappr.Events.CONTAINER_ERROR, callback);
};

exports.onContainerPlaybackdvrstatechanged = function(clappr, callback) {
  return clappr.on(Clappr.Events.CONTAINER_PLAYBACKDVRSTATECHANGED);
};

exports.onContainerPlaybackstateImpl = function(clappr, callback) {
  return clappr.on(Clappr.Events.CONTAINER_PLAYBACKSTATE);
};

exports.onContainerReady = function(clappr, callback) {
  return clappr.on(Clappr.Events.CONTAINER_READY);
};

exports.onContainerStatsReport = function(clappr, callback) {
  return clappr.on(Clappr.Events.CONTAINER_STATS_REPORT);
};

exports.onPlaybackErrorImpl = function(clappr, callback) {
  return clappr.on(Clappr.Events.PLAYBACK_ERROR, callback);
};

exports.onPlayerErrorImpl = function(clappr, callback) {
  return clappr.on(Clappr.Events.PLAYER_ERROR, callback);
};

exports.onPlayerFullscreenImpl = function(clappr, callback) {
  return clappr.on(Clappr.Events.PLAYER_FULLSCREEN, callback);
};

exports.onPlayerPauseImpl = function(clappr, callback) {
  return clappr.on(Clappr.Events.PLAYER_PAUSE, callback);
};

exports.onPlayerPlayImpl = function(clappr, callback) {
  return clappr.on(Clappr.Events.PLAYER_PLAY, callback);
};

exports.onPlayerReadyImpl = function(clappr, callback) {
  return clappr.on(Clappr.Events.PLAYER_READY, callback);
};

exports.onPlayerResizeImpl = function(clappr, callback) {
  return clappr.on(Clappr.Events.PLAYER_RESIZE, callback);
};

exports.onPlayerStopImpl = function(clappr, callback) {
  return clappr.on(Clappr.Events.PLAYER_STOP, callback);
};

exports.onPlayerTimeupdateImpl = function(clappr, callback) {
  return clappr.on(Clappr.Events.PLAYER_TIMEUPDATE, callback);
};

exports.onPlayerVolumeupdateImpl = function(clappr, callback) {
  return clappr.on(Clappr.Events.PLAYER_VOLUMEUPDATE, callback);
};

