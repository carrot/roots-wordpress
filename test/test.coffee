path      = require 'path'
Roots     = require 'roots'

# setup, teardown, and utils

compile_fixture = (fixture_name, done) ->
  @public = path.join(_path, fixture_name, 'public')
  h.project.compile(Roots, fixture_name).then(-> done())

before (done) -> h.project.install_dependencies('*', done)
after -> h.project.remove_folders('**/public')

# tests

describe 'basic', ->

  before (done) -> compile_fixture.call(@, 'basic', done)

  it 'compiles basic project', ->
    p = path.join(@public, 'index.html')
    p.should.be.a.file()
    p.should.have.content.that.match(/en.blog.wordpress.com/)

describe 'errors', ->

  it 'throws an error if no "site" key is provided', ->
    (-> compile_fixture('no_site')).should.throw()
