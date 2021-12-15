// import imagemin from 'imagemin'
import fs from 'fs'
import chalk from 'chalk'
import shell from 'shelljs'
import Jimp from 'jimp'
import path, { basename, dirname } from 'path'; // extname可以获取当前文件后缀名
const __dirname = path.resolve(path.dirname(''));
const compressPath = process.argv.slice(2).length ? process.argv.slice(2).join(' ') : 'static/css.md/'
const lines = shell.exec(
  `git diff --staged --diff-filter=ACR --name-only -z`,
  { silent: true }
)
let arrs = lines ? lines.replace(/\u0000$/, '').split('\u0000') : []
console.log(chalk.yellow('arrs start', arrs))
arrs = arrs.filter(item => {
  const reg = /\.(png|jpg|gif|jpeg)$/
  return reg.test(item)
})
console.log(chalk.yellow('arrs end', arrs))
const compress = async (paths) => {
  const imgPath = path.resolve(__dirname, '../', paths)
  const dirPath = dirname(path.resolve(__dirname, imgPath))
  const base = basename(path.resolve(__dirname, imgPath))
  // await Jimp.read(imgPath).then(lenna => {
  //   return lenna
  //   .quality(70)
  //   .write(path.resolve(__dirname, dirPath, base))
  // }).catch(err => {
  //   console.error(err);
  // })
  await Jimp.read(imgPath, (err, lenna) => {
    if (err) throw err;
    lenna
    .quality(70)
    .write(path.resolve(__dirname, dirPath, base))
  });
  console.log(chalk.green('图片压缩成功', imgPath))
}

arrs.forEach(item => {
  compress(item)
})
if (arrs.length) {
  console.log('运行脚本')
  shell.exec('git add .')
  shell.exec('git commit -m \'perf: 压缩图片\' --no-verify')
} else {
  shell.exec('exit 0', { silent: true })
}

const jimgImg = () => {
  return new Promise((resolve, reject) => {

  })
}