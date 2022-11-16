const userRouter = require('express').Router();
const { PrismaClient } = require('@prisma/client')

const { user } = new PrismaClient();


userRouter.get('/', async (req, res) => {
    const result = await user.findMany().then((result) => {
        res.json({
            result: result
        })
    })
})


module.exports = userRouter