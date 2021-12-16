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
// console.log(chalk.yellow('arrs start', arrs))
arrs = arrs.filter(item => {
  const reg = /\.(png|jpg|gif|jpeg)$/
  return reg.test(item)
})
// console.log(chalk.yellow('arrs end', arrs))
const jimgImg = (imgPath, dirPath, base) => {
  return new Promise((resolve, reject) => {
    Jimp.read(imgPath, (err, lenna) => {
      console.log('图片压缩进行中')
      if (err) throw err;
      lenna
      .quality(70)
      .write(path.resolve(__dirname, dirPath, base))
      resolve()
    })
  })
}
const compress = async (paths) => {
  const imgPath = path.resolve(__dirname, '../', paths)
  const dirPath = dirname(path.resolve(__dirname, imgPath))
  const base = basename(path.resolve(__dirname, imgPath))
  const realPath = path.resolve(__dirname, dirPath, base)
  const image = await Jimp.read(imgPath)
  await image.quality(70)
  // 写文件到本地
  await image.writeAsync(realPath)
  // return new Promise( async (resolve) => {
  //   console.log(chalk.green('图片压缩开始'))
  //   await jimgImg(imgPath, dirPath, base)
  //   console.log(chalk.green('图片压缩成功', imgPath))
  //   resolve()
  // })
}
arrs.forEach(async item => {
  await compress(item)
})
if (arrs.length) {
  setTimeout(() => {
    console.log('运行脚本')
    shell.exec('git add .')
    shell.exec('git commit -m \'perf: 压缩图片\' --no-verify')
  }, 3000)
} else {
  shell.exec('exit 0', { silent: true })
}
