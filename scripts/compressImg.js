// import imagemin from 'imagemin'
import fs from 'fs'
import chalk from 'chalk'
import shell from 'shelljs'
import Jimp from 'jimp'
import path, { basename, dirname } from 'path'; // extname可以获取当前文件后缀名
import { exit, nextTick } from 'process';
let transferCount = 0
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
if (arrs.length > 0) {
  console.log('检测到图片更新，进行压缩')
}
// console.log(chalk.yellow('arrs end', arrs))
const jimgImg = (imgPath, dirPath, base) => {
  return new Promise((resolve, reject) => {
    Jimp.read(imgPath, (err, lenna) => {
      console.log('图片压缩进行中')
      if (err) {
        // reject(err)
        exit(0)
      } else {
        lenna
        .quality(70)
        .writeAsync(path.resolve(__dirname, dirPath, base))
        resolve()
      }
    })
  })
}
const compress = (paths) => {
  return new Promise( async (resolve) => {
    const imgPath = path.resolve(__dirname, '../', paths)
    const dirPath = dirname(path.resolve(__dirname, imgPath))
    const base = basename(path.resolve(__dirname, imgPath))
    // console.log(chalk.green('图片压缩开始'))
    try {
      await jimgImg(imgPath, dirPath, base)
      // shell.exec(`git add "${path.resolve(dirPath, base)}"`)
      transferCount++
      execGit()
      resolve()
    } catch (error) {
      console.log(error)
    }

  })
}
arrs.forEach(async item => {
  await compress(item)
})
const execGit = () => {
  if (arrs.length == transferCount) {
    console.log('脚本执行')
    // if (shell.exec('git add .').code !== 0) {
    //   shell.echo('Error: Git add failed');
    //   shell.exit(1);
    // }
    // if (shell.exec(`git commit -m "压缩图片"`).code !== 0) {
    //   shell.echo('Error: Git commit failed');
    //   shell.exit(1);
    // }
    setTimeout(() => {
      // shell.exec("git add .")
      // shell.exec("git commit -m '压缩图片'")
      shell.exec('./git.sh')
    }, 2000)
    // shell.exit(0)
  }
}
if (!arrs.length) {
  shell.exec('exit 0', { silent: true })
}

