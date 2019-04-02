/* global exports, require */

const BowerResolvePlugin = require("bower-resolve-webpack-plugin");
const path = require('path');

module.exports = {
  entry: path.resolve(__dirname, './output/Examples.Events.Main/index.js'),
  output: {
    filename: 'examplesEvents.js',
    library: 'examplesEvents',
    libraryTarget: 'var',
    path: path.resolve(__dirname),
  },
  resolve: {
    plugins: [new BowerResolvePlugin()],
    modules: ['bower_components', 'node_modules'],
    descriptionFiles: ['bower.json', 'package.json'],
    mainFields: ['browser', 'main']
  }
};
