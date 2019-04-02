const BowerResolvePlugin = require("bower-resolve-webpack-plugin");
const path = require('path');
const webpack = require('webpack');

module.exports = {
  entry: path.resolve(__dirname, './output/Examples.Plugins.Main/index.js'),
  output: {
    filename: 'examplesPlugins.js',
    library: 'examplesPlugins',
    libraryTarget: 'var',
    path: path.resolve(__dirname),
  },
  resolve: {
    alias: {
      'Clappr': 'clappr/dist/clappr.js',
      'clappr-thumbnails-plugin': 'clappr-thumbnails-plugin/dist/clappr-thumbnails-plugin.js'
    },
    plugins: [
      new BowerResolvePlugin()
    ],
    modules: ['bower_components', 'node_modules'],
    descriptionFiles: ['bower.json', 'package.json'],
    mainFields: ['browser', 'main']
  }
};
