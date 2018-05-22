# purescript-clappr

Purescript bindings to Clappr video player.

## Status

Bindings cover:

  * basic options

  * most of event handlers binders

  * most of built-in plugins

  * one extra plugin - `ResponsiveContainer`


## Examples

Examples show:

  * how to attach event handlers

  * how to configure plugins

Both are self-containted - just check build instructions in their READMEs.

### Installation and compilation

You can build examples against cloned library code:

  * `$ npm install`

  * `$ bower install`

  * `$ pulp build -I examples/plugins/src --build-path examples/plugins/output`

  * `$ webpack --config examples/plugins/webpack.config.js`

  * `cd ./examples/plugins`

  * Now edit `index.html` and provide your hls playlist url there (optionally you can provide also your streamroot key)

  * Run some testing http server - for example: `$ python -m http.server`

