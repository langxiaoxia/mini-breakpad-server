path = require 'path'
minidump = require 'minidump'
cache = require './cache'

pool_path = process.env.MINI_BREAKPAD_SERVER_POOL_PATH ? '.'

module.exports.getStackTraceFromRecord = (record, callback) ->
  return callback(null, cache.get(record.id)) if cache.has record.id

  record.path = path.join pool_path, record.path
  console.log 'minidump path:', record.path
  symbolPaths = [ path.join pool_path, 'pool', 'symbols' ]
  console.log 'symbol path:', symbolPaths
  minidump.walkStack record.path, symbolPaths, (err, report) ->
    cache.set record.id, report unless err?
    callback err, report
  , ['-c']
