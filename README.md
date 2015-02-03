Roots Wordpress
================

[![npm](https://img.shields.io/npm/v/roots-wordpress.svg?style=flat)](http://badge.fury.io/js/roots-wordpress) [![tests](https://img.shields.io/travis/carrot/roots-wordpress/master.svg?style=flat)](https://travis-ci.org/carrot/roots-wordpress) [![dependencies](https://img.shields.io/gemnasium/carrot/roots-wordpress.svg?style=flat)](https://gemnasium.com/carrot/roots-wordpress) [![Coverage Status](https://img.shields.io/coveralls/carrot/roots-wordpress.svg?style=flat)](https://coveralls.io/r/carrot/roots-wordpress?branch=master)

Pull wordpress posts into your roots project.

> **Note:** This project is in early development, and versioning is a little different. [Read this](http://markup.im/#q4_cRZ1Q) for more details.

### Installation

- make sure you are in your roots project directory
- `npm install roots-wordpress --save`
- modify your `app.coffee` file to include the extension, as such

  ```coffee
  roots_wordpress = require('roots-wordpress')

  module.exports =
    extensions: [roots_wordpress(site: 'my-wordpress-site.com')]
  ```

### Usage

- Make sure you have a wordpress installation up and running. This can be on wordpress.com, or self-hosted, anything.
- Install the [Jetpack Plugin](https://wordpress.org/plugins/jetpack/).
- Activate Jetpack on the plugins page by signing in with a wordpress.com account
- Go to the Jetpack settings page, find the ["JSON API" module](), and activate it
- Back in your roots project, load in this extension, and configure it with your wordpress site's base url. It can even be an IP address, and there's no need for `http://`.
- Your wordpress posts will now be accessible via a `wordpress` local available in all of your views.

### License & Contributing

- Details on the license [can be found here](LICENSE.md)
- Details on running tests and contributing [can be found here](contributing.md)
