handlebars = require 'handlebars'
umd = require 'umd-wrapper'
sysPath = require 'path'

module.exports = class HandlebarsCompiler
  brunchPlugin: yes
  type: 'template'
  extension: 'hbs'
  pattern: /\.(?:hbs|handlebars)$/

  constructor: (@config) ->
    @config.plugins?.handlebars?.overrides?(handlebars)

  compile: (data, path, callback) ->
    try
      result = umd "Handlebars.template(#{handlebars.precompile data})"
    catch err
      error = err
    finally
      callback error, result

  include: [
    (sysPath.join __dirname, '..', 'vendor',
      'handlebars.runtime-1.0.js')
  ]
