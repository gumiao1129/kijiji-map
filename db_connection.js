var mysql = require('mysql');

var con = mysql.createConnection({
  host: "localhost",
  database: "kijiji_data",
  user: "root",
  password: ""
});



module.exports = { con };