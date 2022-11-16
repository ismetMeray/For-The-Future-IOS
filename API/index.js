const express = require('express')
const app = express()

app.use(express.json())

const route = require('./route/index.route')

app.use('/api', route)

app.listen(5000, () =>{
    console.log("listening on port 5000")
})