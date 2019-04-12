# purescript-clappr

Purescript bindings to Clappr video player.

## Status

Bindings cover:

  * basic options

  * most of event handlers binders

  * most of built-in plugins

  * two extra plugins: `ResponsiveContainer` and `ReplayOnBuffering`

## Extra Plugins

  * `ResponsiveContainer` keeps proportions provided by user and resizing to the parent container

## Installation

This library installs some dependencies using `bower-npm-resolver` so you have to use install this resolver and `.bowerrc` like this:

```json
{
  "resolvers": [
    "bower-npm-resolver"
  ]
}
```

## Examples

There are separate examples provided:

  * `examples/simple` - just shows how to use basic clappr player,

  * `examples/events` - provides example of how to attach event handlers,

  * `examples/plugins` - contains code which configures and uses some provided by this lib plugins.


### Webpack builds


If you work with webpack I can suggest taking a look into examples webpack files. I'm using a combination of "hacks" to make clappr build working. I think the most important piece is this:

```javascript
    alias: { Clappr: 'clappr/dist/clappr.js', 'clappr-thumbnails-plugin': 'clappr-thumbnails-plugin/dist/clappr-thumbnails-plugin.js' },
```

Please check for example `./examples/simple/webpack.config.js` for details.


### Testing

You can build examples against cloned library code:

  * `$ npm install`

  * echo '{ "resolvers": [ "bower-npm-resolver" ] }' >> .bowerrc

  * `$ bower install`

Here we are building example for plugins usage:

  * `$ pulp build -I examples/plugins/src --build-path examples/plugins/output`

  * `$ webpack --config examples/plugins/webpack.config.js`

  * `cd ./examples/plugins`

  * Now edit `./examples/plugins/index.html` and provide your video url (for example hls playlist url) there (optionally you can provide also your streamroot key)

  * Run your favorite testing http server from within example directory (it should serve ./node_modules/clappr path for '.swf' file from root path) - for example: `$ python -m http.server`

