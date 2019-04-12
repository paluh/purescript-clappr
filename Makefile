all: examples/events/examplesEvents.js examples/simple/examplesSimple.js examples/plugins/examplesPlugins.js

./examples/simple/output/Examples.Simple.Main/index.js: examples/simple/src/Main.purs
	pulp build -I examples/simple/src --build-path examples/simple/output

./examples/simple/examplesSimple.js: examples/simple/output/Examples.Simple.Main/index.js
	webpack --config examples/simple/webpack.config.js

./examples/events/output/Examples.Events.Main/index.js: examples/events/src/Main.purs
	pulp build -I examples/events/src --build-path examples/events/output

./examples/events/examplesEvents.js: examples/events/output/Examples.Events.Main/index.js
	webpack --config examples/events/webpack.config.js

./examples/plugins/output/Examples.Plugins.Main/index.js: examples/plugins/src/Main.purs
	pulp build -I examples/plugins/src --build-path examples/plugins/output

./examples/plugins/examplesPlugins.js: examples/plugins/output/Examples.Plugins.Main/index.js
	webpack --config examples/plugins/webpack.config.js
