expect = require("chai").expect
Cmd = require "../../src/cmd"

describe "cmd", ->

  cmd = null

  beforeEach -> cmd = Cmd.init()
  afterEach -> cmd = null

  describe "#exec", ->

    describe "executing a successful command", ->

      it "triggers a callback method", (done) ->

        cmd.exec "echo hello-world", (err, res) ->
          expect(err).to.equal null
          expect(res.message).to.equal "hello-world\n"
          done()

      it "triggers the #then method on the promise object", (done) ->

        cmd
        .exec "echo hello-world"
        .then (res) ->
          expect(res.message).to.equal "hello-world\n"
          done()

    describe "executing a failing command", ->

      it "triggers a callback method", (done) ->

        cmd.exec "fakecmd", (err) ->
          expect(err).to.not.equal null
          done()

      it "triggers the #fail method on the promise object", (done) ->

        cmd
        .exec "fakecmd"
        .fail (err, res) ->
          expect(err).to.not.equal null
          done()

  describe "#cd", ->

    describe "using a valid directory", ->

      it "changes the base directory", (done) ->

        cmd.cd "/"
        expect(cmd.baseDir).to.equal "/"
        done()

      it "returns the cmd object", ->
        expect(cmd).to.equal cmd.cd "/"

  describe "chaining #cd to #exec", ->

    it "triggers a callback method", (done) ->

      cmd
      .cd "/"
      .exec "pwd", (err, res) ->
        expect(err).to.equal null
        expect(res.message).to.equal "/\n"
        done()

    it "triggers the #then method on the promise object", (done) ->

      cmd
      .cd "/"
      .exec "pwd"
      .then (res) ->
        expect(res.message).to.equal "/\n"
        done()
