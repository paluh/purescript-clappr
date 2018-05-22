#!/usr/bin/env sh

pulp build  -I examples/plugins/src/ --build-path examples/plugins/output && webpack --config examples/plugins/webpack.config.js && $(cd ./examples/plugins/ && python -m http.server)
