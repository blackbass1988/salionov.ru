express = require('express')
stylus = require('stylus')
routes = require('./routes')
http = require('http')
path = require('path')

app = express()

app.configure(()->
    app.set 'port', process.env.port || 3000
    app.set 'views', __dirname + '/views'
    app.set 'view engine', 'jade'
    app.use express.favicon()
    app.use express.logger 'dev'
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.cookieParser 'secret'
    app.use express.session()
    app.use app.router
    app.use express.static path.join __dirname, 'public'
    true
)

app.configure 'development', () ->
    app.use express.errorHandler
    app.use stylus.middleware __dirname + '/public'
    true


app.configure 'production', () ->
    app.use stylus middleware {
        src: __dirname + '/public'
        dest: __dirname + '/public'
        compress: true
        debug: false
    }
    true

app.get '/', routes.index
app.get '/workplaces', routes.workplaces

http.createServer(app).listen app.get('port'), () ->
    console.log "Express server listening on port #{app.get 'port'}"
    true

