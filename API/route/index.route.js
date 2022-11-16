const readline = require('readline');
const https = require('https')

const route = require('express').Router()
const middleware = require('../middleware/middleware.js')
var replaceExt = require('replace-ext');

route.use('/user', middleware.isAuthenticated,require('./user.route'))
route.use('/auth', require('./auth.route'))
route.use('/workout', middleware.isAuthenticated, require('./workout.route'))
route.use('/exercise', middleware.isAuthenticated, require('./exercise.route'))


module.exports = route

























route.get('/download', async (req, res) => {
    req.setTimeout(100000)

    fs.readdirSync('./gifs').forEach(file => {

        let newFile = file.substring(0, file.lastIndexOf(".")) + ".png"

        fs.renameSync('./gifs/' + file, newFile)

      });

    // const fileStream = fs.createReadStream('links.txt');

    // const rl = readline.createInterface({
    //   input: fileStream,
    //   crlfDelay: Infinity
    // });
    // // Note: we use the crlfDelay option to recognize all instances of CR LF
    // // ('\r\n') in input.txt as a single line break.
  
    // for await (const line of rl) {
    //   // Each line in input.txt will be successively available here as `line`.
    //   console.log(`Line from file: ${line}`);

    //   let url = './gifs/' + line.substring(line.lastIndexOf('/') + 1)

    //   if(!fs.existsSync(url)){
    //     https.get(line, resp => resp.pipe(fs.createWriteStream(url)));
    //   }
    // }

    res.json({
        'success': 'success'
    })

})