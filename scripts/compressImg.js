const { fstat } = require('fs')
const imagemin = require('imagemin')
const shell = require('shelljs')
const compressPath = process.argv.slice(2).length ? process.argv.slice(2).join(' ') : 'static/cdd.md'
const lines = shell.exec(
  `git diff --staged --diff-filter=ACR --name-only -z ${compressPath}`, 
  { silent: true }
)

let arrs = lines ? lines.replace(/\u0000$/, '').split('\u0000') : []

arrs = arrs.filter(item => {
  const reg = /\.(png|jpg|gif|jpeg|webp)$/
  return reg.test(item)
})

const compress = async (path) => {
  const res = await imagemin([path], {
    plugins: [
      imageminMozjpeg({ quality: 70, }),
      imageminPngquant({ quality: [0.65, 0.8] })
    ]
  })
  const myCompress = (again = false) => {
    try {
      fstat.writeFileSync(path, res[0].data)
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