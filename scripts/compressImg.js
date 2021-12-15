// import imagemin from 'imagemin'
import fs from 'fs'
import chalk from 'chalk'
import shell from 'shelljs'
import Jimp from 'jimp'
import path, { basename, dirname } from 'path'; // extname可以获取当前文件后缀名
const __dirname = path.resolve(path.dirname(''));
// import imageminPngquant from 'imagemin-pngquant'
// import imageminJpegtran from 'imagemin-jpegtran'
const compressPath = process.argv.slice(2).length ? process.argv.slice(2).join(' ') : 'static/css.md/'
console.log(compressPath)
const lines = shell.exec(
  `git diff --staged --diff-filter=ACR --name-only -z`,
  { silent: true }
)
// console.log('lines', lines)
let arrs = lines ? lines.replace(/\u0000$/, '').split('\u0000') : []
console.log('arrs1', arrs)
arrs = arrs.filter(item => {
  const reg = /\.(png|jpg|gif|jpeg|webp)$/
  return reg.test(item)
})
console.log('arrs2', arrs)
if (!arrs.length) {
  console.log(chalk.blue('未检测到图片改动'))
}
// path.resolve(__dirname, '../static/css.md/compress.jpg')
const compress = async (paths) => {
  // const res = await imagemin([path], {
  //   plugins: [
  //     imageminJpegtran({ quality: 70, }),
  //     imageminPngquant({ quality: [0.65, 0.8] })
  //   ]
  // })
  // console.log(path.resolve(__dirname, '../', paths))
  const imgPath = path.resolve(__dirname, '../', paths)
  console.log('压缩图片路径', imgPath)
  // Jimp.read(path.resolve(__dirname, '../', paths), (err, lenna) => {
  //   console.log('err', err)
  //   if (err) throw err;
  //   lenna
  //     .quality(60) // set JPEG quality
  //   console.log('压缩成功')
  // });
  const dirPath = dirname(path.resolve(__dirname, imgPath))
  const base = basename(path.resolve(__dirname, imgPath))
  await Jimp.read(imgPath).then(lenna => {
    return lenna
      .quality(70)
      .write(path.resolve(__dirname, dirPath, base))
  }).catch(err => {
    console.error(err);
  })
  // const myCompress = (again = false) => {
  //   try {
  //     fs.writeFileSync(path, res[0].data)
  //     console.log(chalk.green('压缩图片成功：', path))
  //   } catch (err) {
  //     if (!again) {
  //       tryAgain(myCompress, true)
  //     } else {
  //       console.log(chalk.red('图片压缩失败：'), path)
  //     }
  //   }
  // }
  // myCompress
}

arrs.forEach(item => {
  compress(item)
})
if (arrs.length) {
  shell.exec('git add .', { silent: true })
  shell.exec("git commit -m 'perf: 压缩图片' --no-verify", {
    silent: true
  })
} else {
  shell.exec('exit 0', { silent: true })
}