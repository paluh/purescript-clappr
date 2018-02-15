#!/bin/sh

pulp build -I 'examples/plugins/src/'
webpack --watch --config webpack.examples.js
