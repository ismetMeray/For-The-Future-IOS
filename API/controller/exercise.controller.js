//import prisma client
const { PrismaClient, prisma } = require('@prisma/client');
const { json } = require('body-parser');
const fs = require('fs');
//import models using prismaclient
const { exercise, exerciseData } = new PrismaClient();
const cloudinary = require('cloudinary').v2;


exports.getAllExercises = async (req, res, next) => {

    await exercise.findMany().then((allExercises) => {
        res.json({
            status: 200,
            message: "all exercises",
            data: allExercises
        })
    })
}

exports.getUserExerciseData = async (req, res, next) => {
    let userId = parseInt(req.params.userId)
    let exerciseId = parseInt(req.params.exerciseId)

    await exerciseData.findMany({
        where: {
            userId: userId,
            exerciseId: exerciseId
        }
    }).then((result) => {
        res.json({
            status: 200,
            data: result,
            message: "all data of exercise from user"
        })
    })
}


//fast way of uploading the exercises gifs to the cloud using cloudinary API
exports.uploadimages = (req, res, next) => {

    if (typeof (process.env.CLOUDINARY_URL) === 'undefined') {
        console.warn('!! cloudinary config is undefined !!');
        console.warn('export CLOUDINARY_URL or set dotenv file');
    } else {
        console.log('cloudinary config:');
        console.log(cloudinary.config());
    }

    let folder = './gifs'
    console.log(folder)
    let i = 0
    fs.readdir(folder, function (err, files) {
        if (err) {
            console.log(err)
        }
        let i = 0;
        files.forEach(function (file) {
                let url = './gifs/' + file
                fs.readFile(url, 'base64', (err, res) => {
                    
                    const uploadString = 'data:image/gif;base64,' + res;
                    // if ( i = 100 ){
                    //     console.log(uploadString)
                    // }
                    // i++
                     let newFile = file.substring(0, file.lastIndexOf(".")) + ""
                     const upload = cloudinary.uploader.upload(
                         uploadString,
                        {
                            public_id: newFile,
                            use_filename: true,
                            folder: 'exercisegifs'
                        },
                        function (error, result) {
                            console.log(result, error)
                        })
                })
            })
        })

    res.json({
        status: 200,
        data: {},
        message: "all data of exercise from user"
    })
}