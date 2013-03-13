exports.index = (req, res) ->
    res.render 'index', {title: 'www.salionov.ru'}

exports.workplaces = (req, res) ->
    res.render 'workplaces', {
        title: 'My workplaces'
        bread: [
            {text: 'Main', href: '/'}
            {text: 'My workplaces'}
        ]
        jobs: [
            {name: 'VVSU', descr: 'PHP, JS, VB, C#, MSSQL', time: '2008-2012'}
            {name: 'KamaGames', descr: 'JAVA, PostgreSQL', time: '2012-2013'}
            {name: 'Drom.ru', descr: 'PHP, NodeJS, MySQL, Mongo', time: '2013...'}
        ]
    }
exports.links = (req, res) ->
    res.render 'links', {title: 'Little things'}

exports.screenshot = (req, res) ->
    res.render 'screenshot', {title: 'Web screenshot'}

exports.makeShot = (req, res) ->
    spawn = require('child_process').spawn
    url = req.body.url
    url = 'http://' + url if url[0..4] isnt 'http'
    bin = 'phantomjs'
    script = 'rastorize.coffee'
    file = Math.random(1, 1000) + ".png"
    args = [script, url, file]
    console.log 1
    phtm = spawn bin, args
    console.log 2
    phtm.on('exit', () ->
        path = require 'path'
        fs = require 'fs'
        util = require 'util'
        filePath = path.join process.cwd(), file
        stat = fs.statSync filePath
        res.setHeader "Content-Length", stat.size
        res.setHeader "Content-Disposition", "attachment; filename=\"#{file}\""
        readStream = fs.createReadStream filePath
        util.pump(readStream, res)
        fs.unlink file
        return true
    )
    return true
