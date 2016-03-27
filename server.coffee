'use strict'

express = require "express"
platform = require "platform"
app = express()
require("dotenv").load()

app.enable "trust proxy"

app.get "/", (req, res) ->
  info = platform.parse req.headers['user-agent']
  result =
    ip : req.ip
    lang : req.headers["accept-language"].split(",")[0]
    os : "#{info.os.family} #{info.os.version}"
  console.log "#{new Date()} : #{result.ip}, #{result.lang}, #{result.os}"
  res.send JSON.stringify result

port = process.env.PORT or 8080
app.listen port, ->
  console.log "Server listening on port #{port}..."