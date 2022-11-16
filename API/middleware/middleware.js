require('dotenv').config();

const jwt = require('jsonwebtoken');
const multer = require('multer')

function isAuthenticated(req, res, next) {
    const token = getJsonWebTokenFromRequest(req);
    if (token == null) return res.sendStatus(401);
    jwt.verify(token, process.env.JWT_SECRET_TOKEN, (err, user) => {
        if (err) return res.sendStatus(403);
        next();
    });
}

function getJsonWebTokenFromRequest(req) {
    const authHeader = req.headers['authorization'];
    return authHeader;
}

function multerMW(req, res, next){
    const storage = multer.memoryStorage();
    const multerUploads = multer({ storage }).single('image');
    next()
}

module.exports = {isAuthenticated, getJsonWebTokenFromRequest, multerMW}