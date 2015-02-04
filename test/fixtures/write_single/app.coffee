roots_wordpress = require '../../..'

module.exports =
  ignores: ["**/_*", "**/.DS_Store"]
  extensions: [
    roots_wordpress
      site: 'en.blog.wordpress.com'
      post_types:
        post:
          template: '_single.jade'
  ]

  jade:
    pretty: true
