import Jimp from 'jimp'
// var Jimp = require('jimp');
// import path from 'path'
import path, { basename, dirname } from 'path'; // extname可以获取当前文件后缀名

const __dirname = path.resolve(path.dirname(''));
console.log(dirname(path.resolve(__dirname, 'static/css.md/compress copy 7.jpg')))
Jimp.read('static/css.md/compress copy 7.jpg').then(lenna => {
  return lenna
    .quality(70)
    .write(path.resolve(__dirname, 'static/css.md/', basename(path.resolve(__dirname, 'static/css.md/compress copy 7.jpg'))))
}).catch(err => {
  console.error(err);
})