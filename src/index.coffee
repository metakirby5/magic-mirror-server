bodyParser = require 'body-parser'
cors = require 'cors'
module.exports = app = (require 'express')()

DB =
  'posts': []

app
  .set 'view engine', 'pug'
  .set 'views', "#{__dirname}/views"
  .use bodyParser.urlencoded extended: true
  .use cors()

app.get '/', (req, res) ->
  res.render('index')

app.get '/post-it-form', (req, res) ->
  res.render('post_it_form')

app.route '/post-it'
  .get (req, res) ->
    res.json(DB)
  .post (req, res) ->
    DB.posts.push
      title: req.body.title
      body: req.body.body
    res.redirect '/post-it-form'
