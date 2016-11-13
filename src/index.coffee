bodyParser = require 'body-parser'
cors = require 'cors'
module.exports = app = (require 'express')()

app
  .set 'view engine', 'pug'
  .set 'views', "#{__dirname}/views"
  .use bodyParser.urlencoded extended: true
  .use cors()

app.get '/', (req, res) ->
  res.render('index')

POST_DB =
  'posts': []

app.get '/post-it-form', (req, res) ->
  res.render('post_it_form')

app.route '/post-it'
  .get (req, res) ->
    res.json(POST_DB)
  .post (req, res) ->
    POST_DB.posts.push
      title: req.body.title
      body: req.body.body
      list: req.body.list?
    res.redirect '/post-it-form'
  .delete (req, res) ->
    POST_DB.posts = []
    res.sendStatus 204

QUEUE = []

app.get '/queue-form', (req, res) ->
  res.render('queue_form', {queue: QUEUE})

app.route '/queue'
  .get (req, res) ->
    if QUEUE.length
      res.json({'url': QUEUE.pop()})
    else 
      res.json({'url': ''})
  .post (req, res) ->
    QUEUE.unshift req.body.url
    res.redirect '/queue-form'
  .delete (req, res) ->
    QUEUE = []
    res.sendStatus 204
