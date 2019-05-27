all: examples/events/bundle.js examples/simple/bundle.js examples/plugins/bundle.js

./output/Examples.Simple.Main/index.js: examples/simple/src/Main.purs
	pulp build -I examples/simple/src --build-path ./output

./examples/simple/bundle.js: ./output/Examples.Simple.Main/index.js
	webpack --config examples/simple/webpack.config.js

./output/Examples.Events.Main/index.js: examples/events/src/Main.purs
	pulp build -I examples/events/src --build-path ./output

./examples/events/bundle.js: ./output/Examples.Events.Main/index.js
	webpack --config examples/events/webpack.config.js

./output/Examples.Plugins.Main/index.js: examples/plugins/src/Main.purs
	pulp build -I examples/plugins/src --build-path ./output

./examples/plugins/bundle.js: ./output/Examples.Plugins.Main/index.js
	webpack --config examples/plugins/webpack.config.js
