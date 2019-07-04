# purescript-clappr

Bindings to Clappr video player for Purescript.

## Status

This binding covers:

  * basic options

  * most of event handlers binders

  * most of built-in plugins

  * two extra plugins: `ResponsiveContainer` and `ReplayOnBuffering`

## Extra Plugins

  * `ResponsiveContainer` keeps proportions provided by user and resizing to the parent container

  * `ReplayOnBuffering` reloads playback after a given timeout of buffering.

  * `ClickToStop` because `ClickToPause` doesn't work for live streams.

  * `MediaControl` to customize control bar.

## Installation

This library installs some dependencies using `bower-npm-resolver`, so you have to install this resolver and use `.bowerrc` like this:

```json
{
  "resolvers": [
    "bower-npm-resolver"
  ]
}
```

### Webpack suggestions


If you work with webpack I can suggest taking a look into examples webpack files. I think the most important piece is this:

```javascript
    alias: { Clappr: 'clappr/dist/clappr.js', 'clappr-thumbnails-plugin': 'clappr-thumbnails-plugin/dist/clappr-thumbnails-plugin.js' },
```

Please check for example this file: `./examples/simple/webpack.config.js` for details.


## Examples

There are separate examples provided:

  * `examples/simple` - just shows how to use basic clappr player,

  * `examples/events` - provides example of how to attach event handlers,

  * `examples/plugins` - contains code which configures and uses some provided by this lib plugins.

You can build examples against cloned library code:

  * `$ npm install`

  * `$ echo '{ "resolvers": [ "bower-npm-resolver" ] }' >> .bowerrc`

  * `$ bower install`

  * `$ make` or `$ ./bin/examples.sh` - this script runs `make` and starts simple http server (`python -m http.server`).

  * Please follow the instruction on the examples page on `http://localhost:8000`.

Please note that all examples are compiled into `./output` dir to simplify developement flow. I mean compilation and editing from the root dir and auto rebuild using by for example: `$ webpack --watch examples/plugins/webpack.config.js`).

