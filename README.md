# cmd-exec

[![Build Status](https://secure.travis-ci.org/jpstevens/cmd-exec.png?branch=master)](https://travis-ci.org/jpstevens/cmd-exec)
![Downloads/month](http://img.shields.io/npm/dm/cmd-exec.svg)


## Installation:

To install, go to your console/terminal and run:

```bash
npm install cmd-exec
```

## Usage:

In your project, require the package:

```javascript
var cmd = require("cmd-exec").init();
```

This will return a new instance of the cmd-exec module.

To use multiple instances of cmd-exec:

```javascript
var cmd1, cmd2;

cmd1 = require("cmd-exec").init();
// is not the same as...
cmd2 = require("cmd-exec").init();
```

To execute a command, use:

```javascript
cmd.exec("pwd");
```

The cmd object returns a promise object:

```javascript
cmd
  .exec("pwd")
  .then(function(res){
    console.log(res.message);
  })
  .fail(function(err){
    console.log(err.message);
  })
  .done(function(){
    console.log("Done!");
  });
```

It also triggers a callback, once the command has been executed:

```javascript
cmd.exec("pwd", function(err, res){
  if (err) {
   console.log(err.message);
  } else {
    console.log(res.message);
  }
});
```

Both promises and callbacks are included so that you can implement whichever one best suits your project's code-style.

### Returned objects:

The ```res``` object contains two properties:
- ```res.messages``` is the stdout from the command
- ```res.exitCode``` is the exit code from the command (if specified)

The ```err``` object contains a standard Javascript error:
- ```err.messages``` is the error's message
