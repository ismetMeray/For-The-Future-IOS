//import and make router
require('dotenv').config();

const exerciseRouter = require('express').Router();
const exerciseController = require('../controller/exercise.controller')
const { json } = require('body-parser');
const jwt = require('jsonwebtoken');
const {multerMW} = require('../middleware/middleware')


exerciseRouter.get('/', multerMW,  exerciseController.getAllExercises)
// exerciseRouter.get('/:userId/user', exerciseController.getAllexercise)

exerciseRouter.get('/:userId/user/:exerciseId/exercisedata', exerciseController.getUserExerciseData)
exerciseRouter.get('/upload', exerciseController.uploadimages)

module.exports = exerciseRouter