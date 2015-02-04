rest        = require('rest')
path_prefix = require('rest/interceptor/pathPrefix')
error_code  = require('rest/interceptor/errorCode')
mime        = require('rest/interceptor/mime')

module.exports = rest.wrap(mime, mime: 'application/json')
  .wrap(error_code)
  .wrap(path_prefix, prefix: 'https://public-api.wordpress.com/rest/v1/sites/')
