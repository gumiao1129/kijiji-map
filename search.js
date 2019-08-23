'use strict';
var {con} = require('./db_connection.js')
const kijiji = require("kijiji-scraper");



let options = {
    minResults: 1000
};
 
let params = {
    locationId: 1700113, 
    categoryId: 34,  
    sortByName: "dateDes"  
};


kijiji.search(params, options).then(function(ads) {
    var start = new Date().getTime();
    // Use the ads array
    for (let j = 0; j < ads.length; j++) {

         // Use the ad object
            let ad = ads[j];
            var ad_id = "";
            var sql = "INSERT IGNORE INTO kijiji_ads (title, description, date, image, price, latitude, longitude, mapAddress, province, mapRadius, attributes, url) VALUES ?";
        
            var values = [
                [ad.title, ad.description, ad.date, ad.image, ad.attributes.price, ad.attributes.location.latitude, ad.attributes.location.longitude, ad.attributes.location.mapAddress, ad.attributes.location.province, ad.attributes.location.mapRadius, JSON.stringify(ad.attributes), ad.url]
            ];
            con.query(sql, [values], function (err, result) {
                if (err) throw err;
                ad_id = result.insertId;
                //console.log("insert id: " + ad_id);
               // console.log("Number of records inserted: " + result.affectedRows);


                var images = ad.images;
                for (let i = 0; i < images.length; i++) {
                    let sql = "INSERT IGNORE INTO kijiji_images (ad_id, image_url) VALUES ?";
                    let value = [
                        [ad_id,images[i]]
                    ];
                    //console.log(value);
                    
                    con.query(sql, [value], function (err, result) {
                        if (err) throw err;
                        console.log("image id: " + result.insertId);
                        console.log("Number of images inserted: " + result.affectedRows);
                    });
                    
                }

            });
            
    }
var end = new Date().getTime();
var time = end - start;
console.log("Execution time: " + time + " milliseconds.")
}).catch(console.error);
 
