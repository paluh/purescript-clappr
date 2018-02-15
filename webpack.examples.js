const BowerResolvePlugin = require("bower-resolve-webpack-plugin");

module.exports = {
  entry: './output/Examples.Plugins.Main/index.js',
  output: {
    filename: 'examples/plugins/pluginsExample.js',
    library: 'pluginsExample',
    libraryTarget: 'var'
  },
  resolve: {
    plugins: [new BowerResolvePlugin()],
    modules: ['bower_components', 'node_modules'],
    descriptionFiles: ['bower.json', 'package.json'],
    mainFields: ['browser', 'main']
  }
};
