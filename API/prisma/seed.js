require('dotenv').config();
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()
const axios = require('axios').default;
const bcrypt = require('bcrypt')

async function main() {

  let password = await bcrypt.hash("yeet", 10)

  let user = await prisma.user.upsert({
    where: {
      userName: "boomblaadje"
    },
    update: {},
    create: {
      userName: "boomblaadje",
      passWord: password,
      email: "boomblaadje@yeet.com"
    }
  })
  if (user) {

    if (process.env.RUNEXERCISESEEDERS == 0) {
      const options = {
        method: 'GET',
        url: 'https://exercisedb.p.rapidapi.com/exercises',
        headers: {
          'x-rapidapi-host': 'exercisedb.p.rapidapi.com',
          'x-rapidapi-key': '8548c0be52msh65d5fca7d5d5f20p161982jsncd7ce087223d'
        }
      };

      await axios.request(options).then(async function (response) {
        let exercises = response.data
        console.log(exercises.length)
        for (var i = 1; i < exercises.length; i++) {
          let bodyPart = await seedBodyParts(exercises[i]);
          let equipment = await seedEquipment(exercises[i])
          let muscleTarget = await seedMuscleTarget(exercises[i])

          //console.log(i + " " + exercises[i].name)

          let exercise = await prisma.exercise.findUnique({
            where: {
              name: exercises[i].name
            }
          })
          
          if (!exercise) {
            await prisma.exercise.create({
              data: {
                name: exercises[i].name,
                gifUrl: exercises[i].gifUrl,
                bodyPartId: bodyPart.id,
                equipmentId: equipment.id,
                muscleTargetId: muscleTarget.id
              }
            })
          }
        }
      }).catch(function (error) {
        console.error(error);
      });
    }

    if (process.env.RUNWORKOUTSEEDERS == 1) {
      await prisma.workout.create({
        data: {
          name: "push",
          userId: 1,
          workoutexercise: {
            create: [
              {
                exerciseId: 1,
                order: 1
              },
              {
                exerciseId: 2,
                order: 2
              },
              {
                exerciseId: 3,
                order: 3
              }
            ]
          }
        }
      })
    }
  }
}

async function seedBodyParts(exercise) {
  let bodypart = await prisma.bodyPart.findUnique({
    where: {
      name: exercise.bodyPart
    }
  })

  if (!bodypart) {
    bodypart = await prisma.bodyPart.create({
      data: {
        name: exercise.bodyPart
      }
    })
  }

  return bodypart
}

async function seedEquipment(exercise) {
  let equipment = await prisma.equipment.findUnique({
    where: {
      name: exercise.equipment
    }
  })

  if (!equipment) {
    equipment = await prisma.equipment.create({
      data: {
        name: exercise.equipment
      }
    })
  }

  return equipment
}

async function seedMuscleTarget(exercise) {
  let muscleTarget = await prisma.muscleTarget.findUnique({
    where: {
      name: exercise.target
    }
  })

  if (!muscleTarget) {
    muscleTarget = await prisma.muscleTarget.create({
      data: {
        name: exercise.target
      }
    })
  }

  return muscleTarget
}

main()
  .catch((e) => {
    console.error(e)
    process.exit(1)
  })
  .finally(async () => {
    await prisma.$disconnect()
  })