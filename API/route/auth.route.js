//import and make router
require('dotenv').config();

const authRouter = require('express').Router();
const { json } = require('body-parser');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt')
//import prisma client
const { PrismaClient } = require('@prisma/client')

//import models using prismaclient
const { user } = new PrismaClient();

authRouter.post('/login', async (req, res) => {
    console.log(req.body.username)
    console.log(req.body.password)

    const result = await user.findUnique(
        {
            where: {
                userName: req.body.username
            }
        })

    if (result) {
        if (!await isPasswordValid(result.passWord, req.body.password))
            return res.json({ 'status': 400, 'message': 'Combinatie van gebruikersnaam en wachtwoord is verkeerd.', 'error': "Combinatie van gebruikersnaam en wachtwoord is verkeerd." });
    } else {
        res.json({ 'status': 400, 'message': 'Combinatie van gebruikersnaam en wachtwoord is verkeerd.', 'error': "Combinatie van gebruikersnaam en wachtwoord is verkeerd." })
    }
    const accessToken = await generateAccessToken(result);
    if (accessToken) {
        res.json({
            'status': 200,
            'message': 'logged in succesfully',
            'data': accessToken
        });
    }
});

authRouter.post('/register', async (req, res) => {
    const jsonUser = req.body;
    if (await user.findUnique(
        {
            where: {
                userName: req.body.username
            }
        }) != null) {
        return res.json({
            status: 'Failed',
            message: 'Username already in use.'
        });
    }
    if (await user.findUnique(
        {
            where: {
                email: req.body.email
            }
        }) != null) {
        return res.json({
            status: 'Failed',
            message: 'Email already in use.'
        });
    }

    const finalUser = await user.create({
        data: {
            userName: jsonUser.username,
            email: jsonUser.email,
            passWord: await hashPassword(jsonUser.password)
        }
    })

    return res.json({
        status: 'Success',
        message: 'User registered succesfully.'
    })
});

authRouter.get('/all', async (req, res) => {

    // CreateStandardWorkouts(function(result){
    //     res.json({
    //         list: result
    //     });
    // })
});

async function generateAccessToken(user) {
    if (user) {
        // Payload (data) of jwt &* Do not put sensitive data like a password in the payload **
        const payload = { id: user.id };

        // sign a jwt token with the payload
        return jwt.sign(payload, process.env.JWT_SECRET_TOKEN);
    }
    return null
}

async function isPasswordValid(hashedPassword, plainPassword) {
    const compare = await bcrypt.compare(plainPassword, hashedPassword);
    return compare;
}

async function hashPassword(password) {
    const hash = await bcrypt.hash(password, 10)
    return hash
}

module.exports = authRouter;

