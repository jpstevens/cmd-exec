exec = require("child_process").exec
path = require "path"
Q = require "q"

class Cmd
    
  constructor: ->
    @baseDir = path.resolve "."

  cd: (dir) ->
    @baseDir = path.resolve dir
    @
  exec: (cmd, callback) ->
    # unset callback is it's not a function
    callback = null unless typeof callback is "function"
    # init the defer object
    deferred = Q.defer()
    # exec the command from the basedir
    exec "cd #{@baseDir} && #{cmd}", (err, out, code) ->
      if err
        deferred.reject new Error err
        callback err, { message: out, exitCode: code } if callback
      else
        # update current working directory
        deferred.resolve { message: out, exitCode: code }
        callback null, { message: out, exitCode: code } if callback
    deferred.promise

  @init: ->
    new Cmd

module.exports = Cmd