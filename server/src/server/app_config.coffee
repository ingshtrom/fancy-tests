express = require 'express'
bodyParser = require 'body-parser'
config = require '../config'

# setup the app
# return: express app obj
module.exports.setup_app = () ->
  app = express()
  app.set 'port', config.port
  app.engine "html", 'jade'.__express
  #app.use express.favicon()
  app.use bodyParser.bodyParser()
  app.enable 'trust proxy'

# generate the api for the REST API
# app: express app object
module.exports.setup_api = (app) ->
  # POST
  # GET
  # PUT
  # DELETE