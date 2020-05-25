const mongoose = require('mongoose');
const host = process.env.HOST;
const db = process.env.DB;
const port = process.env.PORT;
const username = process.env.USERNAME;
const password = process.env.PASSWORD;
var connect = 'mongodb://'+host+':'+port+'/'+db;
mongoose.connect(connect, { "auth": { "authSource": "admin" },
"user": username, "pass": password, useNewUrlParser: true, useUnifiedTopology: true}, (err) => {

            if(!err){
                console.log("Mongo Connection Succeeded.")
            }

            else{
                console.log('Configuration error' + err)
            }

        });

require('./employee.model');
