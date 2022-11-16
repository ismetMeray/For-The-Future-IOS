//import prisma client
const { PrismaClient, prisma } = require('@prisma/client');
//import models using prismaclient
const { user, workout, workoutexercise } = new PrismaClient();

exports.getWorkoutById = async (req, res, next) => {

    await workout.findUnique({
        where: {
            id: parseInt(req.params.workoutId)
        },
        include: {
            workoutexercise: { include: { exercise: true } }
        }
    }).then((allWorkouts) => {
        res.json({
            workout: allWorkouts
        })
    })
}

exports.getAllWorkoutOfUser = async (req, res, next) => {
    let userId = parseInt(req.params.userId)

    await workout.findMany({
        include: {
            workoutexercise: {
                select: {
                    exercise: {
                        select: {
                            id: true,
                            name: true,
                            gifUrl: true,
                            updateAt: true,
                            createdAt: true,
                            bodyPart: true,
                            equipment: true,
                            muscleTarget: true
                        }
                    },
                    exerciseData: {
                        select: {
                            id: true,
                            userId: true,
                            workoutId: true,
                            exerciseId: true,
                            repetitions: true,
                            weight: true,
                            createdAt: true,
                            updateAt: true
                        }
                    },

                    order: true,

                }
            },
        },
        where: {
            userId: userId,
        }
    }).then((result) => {
        res.json({
            status: 200,
            message: "selected all workout of",
            data: result
        })
    })
}

exports.addExerciseToWorkoutById = async (req, res, next) => {
    let userId = parseInt(req.params.userId)
    let workoutId = parseInt(req.params.workoutId)
    let exercisesToAdd = JSON.parse(req.body.exercisestoadd)
    console.log(userId)
    console.log(workoutId)
    console.log(exercisesToAdd)
    console.log(exercisesToAdd[0].exercise.id)
    console.log(exercisesToAdd[0].order)

    for (var i = 0; i < exercisesToAdd.length; i++) {

        await workoutexercise.create({
            data: {
                exercise: {
                    connect: {
                        id: exercisesToAdd[i].exercise.id
                    }
                },
                order: exercisesToAdd[i].order,
                workout: {
                    connect: { id: workoutId }
                }
            }
        })
    }
    res.json({
        status: 200,
        message: "succcc",
        data: 1,
    })
    // add exercise: {create shit}
    // let workout = await workoutexercise.create({
    //     data: {
    //         exerciseId: exerciseId,
    //         workoutId: workoutId,
    //         order: order,
    //     }

    // }).then((result) => {
    //     res.json({
    //         status: 200,
    //         result: result
    //     })
    // })
}

exports.getNrOfWorkouts = async (req, res, next) => {

    let userId = parseInt(req.params.userId)

    await workout.findMany({
        where: {
            userId: userId,
        }
    }).then((result) => {
        res.json({
            status: 200,
            message: "Nr or workouts are: " + result.length,
            data: result.length
        })
    })
}

exports.saveWorkoutRoutine = async (req, res, next) => {
    var json = JSON.parse(req.body.workout)
    // var wo = req.body.workout

    await workout.create({
        data: {
            id: json.id,
            name: json.name,
            userId: json.userId,
        }
    }).then((result) => {
        res.json({
            status: 200,
            message: "succcc",
            data: json.id
        })
    })
}