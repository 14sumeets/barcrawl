var express = require('express')
var bodyParser = require('body-parser')
var app = express()

app.use(bodyParser.urlencoded({ extended: false }))
allConnections = {}

app.post('/', function(req, res){
	connection = {latitude : req.body.latitude, longitude : req.body.longitude}
	allConnections[req.ip] = connection
	console.log(allConnections)
	res.send("hello world!")
})

var server = app.listen(3000, function() {
    console.log('Listening on port %d', server.address().port);
});