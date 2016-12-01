path  = require 'path'
fs    = require 'fs'
Roots = require 'roots'

# setup, teardown, and utils

compile_fixture = (fixture_name, done) ->
  @public = path.join(_path, fixture_name, 'public')
  h.project.compile(Roots, fixture_name).then(-> done())

before (done) -> h.project.install_dependencies('*', -> done())
after -> h.project.remove_folders('**/public')

# tests

describe 'basic', ->

  before (done) -> compile_fixture.call(@, 'basic', done)

  it 'compiles basic project', ->
    p = path.join(@public, 'index.html')
    p.should.be.a.file()
    p.should.have.content.that.match(/en.blog.wordpress.com/)

describe 'write_single', ->

  before (done) -> compile_fixture.call(@, 'write_single', done)

  it 'compiles and writes single pages to a specified template', ->
    index = path.join(@public, 'index.html')
    posts = fs.readdirSync(path.join(@public, 'post'))
    post = path.join(@public, 'post', posts[0])

    posts.length.should.equal(20)
    index.should.be.a.file()
    index.should.have.content.that.match(/<li>post\//)
    post.should.be.a.file()
    post.should.have.content.that.match(/h1/)

describe 'wp_params', ->

  before (done) -> compile_fixture.call(@, 'wp_params', done)

  it 'passes wordpress querystring params through', ->
    posts = fs.readdirSync(path.join(@public, 'post'))
    posts.length.should.equal(10)

describe 'errors', ->

  it 'throws an error if no "site" key is provided', ->
    (-> compile_fixture('no_site')).should.throw()
