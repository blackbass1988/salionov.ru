express = require('express')
stylus = require('stylus')
routes = require('./routes')
http = require('http')
path = require('path')

app = express()

port = process.env.port || 3000;

app.set 'port', port
app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'
app.use express.favicon()
app.use express.logger 'dev'
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.cookieParser 'secret'
app.use app.router

if 'production' is app.get 'env'
  app.use stylus.middleware {
    src: __dirname + '/public'
    dest: __dirname + '/public'
    compress: true
    debug: false
  }
if 'development' is app.get 'env'
  app.use stylus.middleware __dirname + '/public'
  app.use(express.errorHandler())

app.use express.static path.join __dirname, 'public'




app.get '/', routes.index
app.get '/workplaces', routes.workplaces
app.get '/links', routes.links
app.get '/shot', routes.screenshot
app.post '/shot', routes.makeShot
#app.all '*', (req, res) ->
#  res.status 404
#  res.json 'oops'


http.createServer(app).listen app.get('port'), () ->
    console.log "Express server listening on port #{app.get 'port'}"
    true

