'use strict';

const BowerWebpackPlugin = require('bower-webpack-plugin');
const path = require('path');
const webpack = require('webpack');

const bowerWebpackPlugin = new BowerWebpackPlugin({moduleDirectories: ['./bower_components']});
const plugins = [bowerWebpackPlugin];

module.exports = function(env) {
  var entries = {}, pscBundleArgs = {};

  if(env.pux) {
    entries.pux = './output/Examples.Pux/index.js';
    pscBundleArgs = {'module': 'Examples.Pux'};
  } else {
    entries.simple = './output/Examples.Simple/index.js';
    pscBundleArgs = {'module': 'Examples.Simple'};
  }

  return {
    entry: entries,
    node: {
      fs: 'empty'
    },
    output: {
      path: path.join(__dirname, './output'),
      pathinfo: true,
      library: '[name]',
      libraryTarget: 'var',
      filename: '[name].bundle.js',
    },
    plugins: plugins,
    // externals: {
    //  clappr: {
    //   amd: 'Clappr',
    //   commonjs: 'Clappr',
    //   commonjs2: 'Clappr',
    //   root: 'Clappr'
    //  }
    // },
    module: {
      loaders: [
        // {
        // test: /\.purs$/,
        // loader: "purs-loader",
        // we probably want this on prod build
        // query: {
        //     bundle: !env.devel,
        //     output: './output',
        //     psc: 'psa',
        //     pscArgs: env.devel?{}:{'no-prefix': true},
        //     pscBundleArgs: pscBundleArgs,
        //     pscIde: true,
        //     pscIdeArgs: {'port': 4089},
        //     // vim should force recompilation of other files
        //     src: [ 'bower_components/purescript-*/src/**/*.js', 'bower_components/purescript-*/src/**/*.purs', 'src/**/*.js'], //'examples/**/*.purs'  ],
        //     watch: env.devel
        //   }
        // },
        {
          test: /\.js$/,
          loader: 'babel-loader',
          include: [path.resolve(__dirname, 'bower_components/clappr0-hlsjs-provider/provider.js')]
          // exclude: [/hls.js/, /p2p/],
        },
        {
          test: /\.scss$/,
          loaders: ['css-loader', 'sass-loader' ],
        }, {
          test: /\.html/, loader: 'html-loader?minimize=false'
        },
      ]
    },
    resolve: {
      plugins: [bowerWebpackPlugin],
      modules: [
        './bower_components',
        './node_modules',
      ],
      extensions: [ '.purs', '.js'],
      descriptionFiles: ['bower.json', 'package.json'],
      mainFields: ['main', 'browser']
    }
  };
}
