//import and make router
require('dotenv').config();

const workoutRouter = require('express').Router();
const workoutController = require('../controller/workout.controller')
const { json } = require('body-parser');
const jwt = require('jsonwebtoken');


// workoutRouter.get('/:id', workoutController.getWorkoutById)
// workoutRouter.post('/:workoutId/:exerciseId/:order', workoutController.addExerciseToWorkoutById)
workoutRouter.get('/:userId/nrofworkouts', workoutController.getNrOfWorkouts)
workoutRouter.get('/:userId/user', workoutController.getAllWorkoutOfUser)
workoutRouter.get('/:userId/nrofworkouts', workoutController.getNrOfWorkouts)
workoutRouter.post('/:userId/user/:workoutId/newworkoutroutine', workoutController.saveWorkoutRoutine)
workoutRouter.post('/:userId/user/:workoutId/addexercisetoworkoutroutine', workoutController.addExerciseToWorkoutById)
module.exports = workoutRouter