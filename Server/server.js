const express = require('express')
const mongoose = require('mongoose')
const Data = require('./noteSchema')
var app = express()
var data = require('./noteSchema')

mongoose.set('strictQuery', true);


mongoose.connect("mongodb://localhost/myDB")

mongoose.connection.once("open", () => {
    console.log("Connected to database!")
}).on("error", (error) => {
    console.log("Failed to connect " + error)
})


//CREATE A NOTE
//POST request
app.post("/create", (req, response) => {
    var note = new Data({
        note: req.get("note"),
        title: req.get("title"),
        date: req.get("date")
    })

    note.save().then(() => {
        if(note.isNew == false) {
            console.log("Saved Data")
            response.send("Saved Data!")
        } else {
            console.log("Failed to save data")
        }
    })
})

//FETCH ALL NOTES
//GET request
app.get('/fetch', (req, response) => {
    Data.find({}).then((DBitems) => {
        response.send(DBitems)
    })
})

// http://10.5.42.158:8081/create
var server = app.listen(8081, "10.5.42.158", () => {
    console.log("Server is running!")
})

//DELETE A NOTE
//POST request
app.post('/delete', (req, response) => {
    Data.findOneAndRemove({
        _id: req.get("id")
    }, (err) => {
        console.log("Failed" + err)
    })
    response.send("Deleted!")
})

//UPDATE A NOTE
//POST request
app.post('/update', (req, response) => {
    Data.findOneAndUpdate({
        _id: req.get("id")
    }, {
        note: req.get("note"),
        title: req.get("title"),
        date: req.get("date")
    }, (err) => {
        console.log("Failed to update " + err)
    })
    response.send("Updated!")
})
