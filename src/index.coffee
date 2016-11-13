app = (require 'express')()

module.exports = app

app.get '/', (req, res) ->
  res.send('test')
