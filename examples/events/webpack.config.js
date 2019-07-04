/*jshint esversion: 6 */

const path = require('path');

module.exports = {
  entry: path.resolve(__dirname, '../../output/Examples.Events.Main/index.js'),
  output: {
    filename: 'bundle.js',
    library: 'examplesEvents',
    libraryTarget: 'var',
    path: path.resolve(__dirname),
  },
  resolve: {
    alias: {
      Clappr: 'clappr/dist/clappr.js'
    },
    modules: ['bower_components', 'node_modules'],
    descriptionFiles: ['bower.json', 'package.json'],
    mainFields: ['browser', 'main']
  }
};
