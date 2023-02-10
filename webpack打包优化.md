1. 已经打包过的插件不需要再次打包
使用`include`指定编译文件夹，使用`exclude`来指定排除文件夹
```js
{ 
  test: /\.js$/, 
  //使用include来指定编译文件夹
  include: path.resolve(__dirname, '../src'),
  //使用exclude排除指定文件夹
  exclude: /node_modules/
  use: [{
    loader: 'babel-loader'
  }]
}
```
2. 合理的利用缓存来减少打包时间, 在开销较大的loader前使用即可
```js
 {
  test: /\.js$/,
  use: [
    'cache-loader',
    'babel-loader'
  ],
  include: path.resolve('src')
}
```
3. 合理配置relosve，防止减慢打包时间，但是正由于这样的便利，大家为了方便，就会配置许多后缀，比如jpg、css、png 等，由于不写后缀，他在查找的时候，会给 extensions数组中的所有后缀遍历完了找不到才去报错，这样就大大增加了查找时间，所以，大家还是要合理配置

```js
//这样配置我们就不用写后缀了
resolve:{
    extensions:['js','jsx']
}
```

4. ParallelUglifyPlugin：我们知道压缩 JS 需要先将代码解析成 AST 语法树，然后需要根据复杂的规则去分析和处理 AST，最后将 AST 还原成 JS，这个过程涉及到大量计算，因此比较耗时，那么我们使用ParallelUglifyPlugin这个插件就能开启多进程压缩JS使用方式也非常简单
```js
//引入插件
const ParallelUglifyPlugin = require('webpack-parallel-uglify-plugin')
 plugins: [
// 使用 ParallelUglifyPlugin 并行压缩输出的 JS 代码
  new ParallelUglifyPlugin({
    // 传递给 UglifyJS 的参数
    // （还是使用 UglifyJS 压缩，只不过帮助开启了多进程）
    uglifyJS: {
      output: {
        beautify: false, // 最紧凑的输出
        comments: false, // 删除所有的注释
      },
      compress: {
        // 删除所有的 `console` 语句，可以兼容ie浏览器
        drop_console: true,
        // 内嵌定义了但是只用到一次的变量
        collapse_vars: true,
        // 提取出出现多次但是没有定义成变量去引用的静态值
        reduce_vars: true,
      }
    }
  })
 ]
```

5. 路由懒加载
6. 小图片使用base64，不使用网络请求
```js
rules: [
// 图片 - 考虑 base64 编码的情况
  {
    test: /\.(png|jpg|jpeg|gif)$/,
    use: {
      loader: 'url-loader',
      options: {
        // 小于 5kb 的图片用 base64 格式产出
        // 否则，依然延用 file-loader 的形式，产出 url 格式
        limit: 5 * 1024,
        // 打包到 img 目录下
        outputPath: '/img1/',
        // 设置图片的 cdn 地址（也可以统一在外面的 output 中设置，那将作用于所有静态资源）
        // publicPath: 'http://cdn.abc.com'
      }
    }
  },
]
```
7. tree-shaking，配置 mode production即可