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
    plugins: [
      new BowerResolvePlugin()
    ],
    modules: ['bower_components', 'node_modules'],
    descriptionFiles: ['bower.json', 'package.json'],
    mainFields: ['browser', 'main']
  }
};
