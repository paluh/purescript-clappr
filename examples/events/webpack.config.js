const BowerResolvePlugin = require("bower-resolve-webpack-plugin");

module.exports = {
  entry: './output/Main/index.js',
  output: {
    filename: 'bundle.js',
    library: 'clapprEventsLogger',
    libraryTarget: 'var'
  },
  resolve: {
    plugins: [new BowerResolvePlugin()],
    modules: ['bower_components', 'node_modules'],
    descriptionFiles: ['bower.json', 'package.json'],
    mainFields: ['browser', 'main']
  }
};
