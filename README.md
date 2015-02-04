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
  wordpress = require('roots-wordpress')

  module.exports =
    extensions: [
      wordpress
        site: 'my-wordpress-site.com'
        post_types:
          post: { template: 'views/_single_post.jade' }
    ]
  ```

### Setup

- Make sure you have a wordpress installation up and running. This can be on wordpress.com, or self-hosted, anything.
- Install the [Jetpack Plugin](https://wordpress.org/plugins/jetpack/).
- Activate Jetpack on the plugins page by signing in with a wordpress.com account
- Go to the Jetpack settings page, find the ["JSON API" module](https://s3.amazonaws.com/f.cl.ly/items/2Y391I1D321L3k3d0A2X/Screen%20Shot%202015-02-03%20at%2012.30.50%20PM.png), and activate it
- Back in your roots project, load in this extension, and configure it with your wordpress site's base url and your post types.
- Your wordpress content will be available to all views on the `wordpress` local.

### Configuration

The `site` option accepts the domain of your wordpress site. You can include `http://` at the beginning or not, your choice. It is not needed. Most of the configuration is in the `post_types` though, where you are able to configure how this extension makes calls to wordpress and organizes your content once it's back in roots.

Wordpress can have a number of different "post types" -- the default is that it has just one, `post`. You can add custom post types with a bit of PHP code, and wordpress also has an automatically configured `portfolio` post type which can be enabled through the settings.

In the `post_types` array, `roots-wordpress` expects one or more objects, the key being the name of the post type and the value being an object full of configuration settings. If you pass a `template` value, each post from that post type will be rendered into the specified template named by the `slug` property on the response in a folder named after the post type, and a `_url` property will be added to each post pointing to the path of the single view.

All other options you can pass directly mirror those that [wordpress' api provides](https://developer.wordpress.com/docs/api/1/get/sites/%24site/posts/). Any of the options in the "Query Parameters" section can be passed in to any post type's configuration object and they will be applied directly to that request. So, for example:

```coffee
wordpress
  site: 'example.com'
  post_types:
    portfolio:
      template: 'views/_portfolio_single.jade'
      category: 'new'
```

This snippet would pull any items in the portfolio post type that are in the `new` category into `wordpress.portfolio` in your locals, and render out a single view using the specific template for each portfolio item in `public/portfolio/{wordpress-slug}.html`.

Within that template, all the data for your post type will be available under the `post` local. The local always remains the same no matter the content type for consistency, it's always `post`.

If this seems confusing, feel free to check the `test/fixtures` folder for a couple working examples!

### Using Custom Post Types

If you want to create and consume a custom post type from wordpress, only a small adjustment is needed. First, you need to work some PHP magic within wordpress to create your post type in the first place. Then you'll need to add the `rest_api_allowed_post_types` filter, more info on this process can be found [here](https://developer.wordpress.com/2013/04/26/custom-post-type-and-metadata-support-in-the-rest-api/).

Once you have done this, you can just add the name of the post type to `post_types`, pass any options you need, and you should be all set!

### License & Contributing

- Details on the license [can be found here](LICENSE.md)
- Details on running tests and contributing [can be found here](contributing.md)
