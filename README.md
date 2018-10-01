# purescript-clappr

Purescript bindings to Clappr video player.

__Not ported to ps-0.12 (tested against ps-0.11.7).__

## Status

Bindings cover:

  * basic options

  * most of event handlers binders

  * most of built-in plugins

  * two extra plugins: `ResponsiveContainer` and `ReplayOnBuffering`


## Examples

Examples show:

  * how to attach event handlers

  * how to configure plugins

### Installation and compilation

You can build examples against cloned library code:

  * `$ npm install`

  * `$ bower install`

  * `$ pulp build -I examples/plugins/src --build-path examples/plugins/output`

  * `$ webpack --config examples/plugins/webpack.config.js`

  * `cd ./examples/plugins`

  * Now edit `index.html` and provide your video url (for example hls playlist url) there (optionally you can provide also your streamroot key)

  * Run some testing http server (it should serve ./node_modules/clappr path for '.swf' file from root path) - for example: `$ python -m http.server`

