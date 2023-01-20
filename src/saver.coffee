fs = require 'fs-plus'
path = require 'path'
mkdirp = require 'mkdirp'
Record = require './record'

pool_path = process.env.MINI_BREAKPAD_SERVER_POOL_PATH ? '.'

exports.saveRequest = (req, db, callback) ->
  Record.createFromRequest req, (err, record) ->
    return callback new Error("Invalid breakpad request") if err?

    dist = "pool/files/minidump"
    dist_abs = path.join pool_path, dist
    console.log 'minidump path:', dist_abs
    mkdirp dist_abs, (err) ->
      return callback new Error("Cannot create directory: #{dist_abs}") if err?

      filename = path.join dist, record.id
      filename_abs = path.join dist_abs, record.id
      fs.copy record.path, filename_abs, (err) ->
        return callback new Error("Cannot create file: #{filename_abs}") if err?

        record.path = filename
        db.saveRecord record, (err) ->
          return callback new Error("Cannot save record to database") if err?

          callback null, filename
