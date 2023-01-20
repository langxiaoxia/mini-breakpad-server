path = require 'path'
formidable = require 'formidable'
uuid = require 'node-uuid'

class Record
  id: null
  time: null
  path: null
  product: null
  version: null
  platform: null
  osarch: null
  ptype: null
  fields: null

  constructor: ({@id, @time, @path, @sender, @product, @version, @platform, @osarch, @ptype, @fields}) ->
    @id ?= uuid.v4()
    @time ?= new Date

  # Public: Parse web request to get the record.
  @createFromRequest: (req, callback) ->
    form = new formidable.IncomingForm()
    form.parse req, (error, fields, files) ->
      unless files.upload_file_minidump?.originalFilename?
        return callback new Error('Invalid breakpad upload')

      console.log 'original ' + files.upload_file_minidump.originalFilename
      console.log 'filepath ' + files.upload_file_minidump.filepath
      record = new Record
        path: files.upload_file_minidump.filepath
        sender: {ua: req.headers['user-agent'], ip: Record.getIpAddress(req)}
        product: fields.prod
        version: fields.ver
        platform: fields.platform
        osarch: fields.osarch
        ptype: fields.ptype
        fields: fields
      callback(null, record)

  # Public: Restore a Record from raw representation.
  @unserialize: (id, representation) ->
    new Record
      id: id
      time: new Date(representation.time)
      path: representation.path
      sender: representation.sender
      product: representation.fields.prod
      version: representation.fields.ver
      platform: representation.fields.platform
      osarch: representation.fields.osarch
      ptype: representation.fields.ptype
      fields: representation.fields

  # Private: Gets the IP address from request.
  @getIpAddress: (req) ->
    req.headers['x-forwarded-for'] || req.connection.remoteAddress

  # Public: Returns the representation to be stored in database.
  serialize: ->
    time: @time.getTime(), path: @path, sender: @sender, fields: @fields

module.exports = Record
