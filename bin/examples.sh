#!/usr/bin/env bash

function build() {
  echo "Building examples/$1/ ..."
  pulp build -I examples/$1/src --build-path examples/$1/output
  webpack --config examples/$1/webpack.config.js
}

build simple

build plugins

build events

python -m http.server
