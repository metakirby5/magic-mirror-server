bodyParser = require 'body-parser'
module.exports = app = (require 'express')()

DB =
  'posts': []

app
  .set 'view engine', 'pug'
  .set 'views', "#{__dirname}/views"
  .use bodyParser.urlencoded extended: true

app.get '/', (req, res) ->
  res.render('post_it_form')

app.route '/post-it'
  .get (req, res) ->
    res.json(DB)
  .post (req, res) ->
    console.log "Got post: #{req.body}"
    DB.posts.push
      title: req.body.title
      body: req.body.body
    res.redirect '/'
