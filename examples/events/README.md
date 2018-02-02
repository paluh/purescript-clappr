# Purpose

In this example I'm registering all allowed (by current implementation) handlers and I'm logging all events to the console so you can easily watch what is triggered and when.

# Usage

 1. Run:

    $ npm install
    $ bower update
    $ webpack --config webpack.config.js

  2. Edit index.html and set your hls stream url there. Just google for some free hls streams ;-)

  3. Run some simpe http server to serve local files. For example:

    $ python -m http.server 8000

  4. Check results in your favorite browser: http://localhost:8000/index.html
