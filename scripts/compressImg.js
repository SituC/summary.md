// import imagemin from 'imagemin'
import fs from 'fs'
import chalk from 'chalk'
import shell from 'shelljs'
import jimp from 'jimp'
// import imageminPngquant from 'imagemin-pngquant'
// import imageminJpegtran from 'imagemin-jpegtran'
const compressPath = process.argv.slice(2).length ? process.argv.slice(2).join(' ') : '../../static/cdd.md/'
console.log(compressPath)
const lines = shell.exec(
  `git diff --staged --diff-filter=ACR --name-only -z`,
  { silent: true }
)
console.log('lines', lines)
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
const compress = async (path) => {
  console.log('压缩图片路径', path)
  // const res = await imagemin([path], {
  //   plugins: [
  //     imageminJpegtran({ quality: 70, }),
  //     imageminPngquant({ quality: [0.65, 0.8] })
  //   ]
  // })
  const res = await jimp.read(path).then(lenna => {
    return lenna
      .quality(70)
  })
  console.log('压缩', res)
  const myCompress = (again = false) => {
    try {
      fs.writeFileSync(path, res[0].data)
      console.log(chalk.green('压缩图片成功：', path))
    } catch (err) {
      if (!again) {
        tryAgain(myCompress, true)
      } else {
        console.log(chalk.red('图片压缩失败：'), path)
      }
    }
  }
  myCompress
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