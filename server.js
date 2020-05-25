require('./models/db');

const express = require('express');
const path = require('path');
const exphbs = require('express-handlebars');
const Handlebars = require('handlebars');
const employeeController = require('./controllers/employeeController'); 
const bodyparser = require('body-parser');

var app = express();
const {allowInsecurePrototypeAccess} = require('@handlebars/allow-prototype-access');
app.use(bodyparser.urlencoded({
    extended:   true
}));
app.use(bodyparser.json());
app.set('views', path.join(__dirname,'/views/'));
app.engine('hbs',exphbs({
    extname:'hbs',
    defaultLayout: 'mainLayout',
    handlebars: allowInsecurePrototypeAccess(Handlebars),
    layoutsDir: __dirname + '/views/layouts/'
}));

app.set('view engine', 'hbs');

app.listen(3000,() => {
    console.log("Express at port 3000")
});

app.use('/employee',employeeController);