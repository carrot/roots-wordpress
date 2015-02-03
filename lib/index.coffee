API = require('./api')

module.exports = (opts = {}) ->

  class RootsWordpress
    constructor: (@roots) ->
      if not opts.site then throw new Error('You must supply a site url or id')
      opts.site = opts.site.replace(/http:\/\//, '')
    
    setup: ->
      API(path: "#{opts.site}/posts").then (res) =>
        @roots.config.locals ?= {}
        @roots.config.locals.wordpress = res.entity
