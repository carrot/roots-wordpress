var chai = require('chai'),
    chai_fs = require('chai-fs'),
    chai_promise = require('chai-as-promised'),
    path = require('path'),
    Util = require('roots-util');

var _path = path.join(__dirname, '../fixtures'),
    h = new Util.Helpers({ base: _path });

var should = chai.should();
chai.use(chai_fs);
chai.use(chai_promise);

global.chai = chai;
global.should = should;
global.h = h;
global._path = _path;
