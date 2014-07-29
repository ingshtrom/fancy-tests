appConfig = require './app'

app = appConfig.init()

appConfig.setup_api(app)