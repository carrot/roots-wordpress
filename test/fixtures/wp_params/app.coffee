roots_wordpress = require '../../..'

module.exports =
  ignores: ["**/_*", '_*', "**/.DS_Store"]
  extensions: [
    roots_wordpress
      site: 'en.blog.wordpress.com'
      post_types:
        post:
          template: '_single.jade'
          number: 10
  ]

  jade:
    pretty: true
