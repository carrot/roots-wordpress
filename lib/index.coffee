API       = require './api'
W         = require 'when'
RootsUtil = require 'roots-util'
merge     = require 'lodash.merge'
find      = require 'lodash.find'
cloneDeep = require 'lodash.cloneDeep'
includes  = require 'lodash.includes'
path      = require 'path'

module.exports = (opts = {}) ->
  if not opts.site then throw new Error('You must supply a site url or id')
  if not opts.post_types then opts.post_types = { post: {} }

  class RootsWordpress
    constructor: (@roots) ->
      @util = new RootsUtil(@roots)
      opts.site = opts.site.replace(/http:\/\//, '')

    setup: ->
      @roots.config.locals ?= {}
      @roots.config.locals.wordpress = {}

      all = for type, config of opts.post_types
        request(opts.site, type, config)
          .then(render_single_views.bind(@, config, type))
          .then(add_urls_to_posts)
          .then(add_posts_to_locals.bind(@, type))

      W.all(all)

# private

request = (site, type, config) ->
  params = merge({}, config, type: type)
  delete params.template
  API({ path: "#{site}/posts", params: params })

render_single_views = (config, type, res) ->
  posts = res.entity.posts

  if not config.template then return { urls: [], posts: posts }

  W.map posts, (p) =>
    directory = if config.directory then config.directory else type
    tpl = path.join(@roots.root, config.template)
    locals   = merge({}, @roots.config.locals, post: p)
    extension = if typeof @roots.config.server == 'object' && @roots.config.server.clean_urls then '' else '.html'
    outputFile = "#{directory}/#{p.slug}.html"
    outputLink = "#{directory}/#{p.slug}#{extension}"
    compiler = find @roots.config.compilers, (c) ->
      includes(c.extensions, path.extname(tpl).substring(1))

    compiler.renderFile(tpl, cloneDeep(locals))
      .then((res) => @util.write(outputFile, res.result))
      .yield(outputLink)

  .then (urls) -> { urls: urls, posts: posts }

add_urls_to_posts = (obj) ->
  obj.posts.map (post, i) ->
    post._url = obj.urls[i]
    post

add_posts_to_locals = (type, posts) ->
  @roots.config.locals.wordpress[type] = posts
