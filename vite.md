
# dev-dev-server
从文档中的注释，引用[谷歌翻译](https://link.juejin.cn?target=https%3A%2F%2Ftranslate.google.cn%2F "https://translate.google.cn/")。作用大致如下：

-   浏览器请求导入作为原生 ES 模块导入 - 没有捆绑。
-   服务器拦截对 *.vue 文件的请求，即时编译它们，然后将它们作为 JavaScript 发回。
-   对于提供在浏览器中工作的 ES 模块构建的库，只需直接从 CDN 导入它们。
-   导入到 .js 文件中的 npm 包（仅包名称）会即时重写以指向本地安装的文件。 目前，仅支持 vue 作为特例。 其他包可能需要进行转换才能作为本地浏览器目标 ES 模块公开。

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/6622b4cd7cd646d1994f0a2d0e26fcd5~tplv-k3u1fbpfcp-watermark.image?)
通过图上内容，简单分析：通过一个`server`服务，拦截浏览器对资源的请求，也就是`route`，然后对各个模块`module`进行处理，最后响应资源文件。
# vueMiddleware

## cache
为了优化加载速度，当浏览器第二次请求资源文件时，`vue-dev-server`都是直接从内存中拿到缓存文件直接响应给浏览器。缓存主要是通过`lru-cache`这个库，用于在内存中管理缓存数据，并且支持LRU算法。可以让程序不依赖任何外部数据库实现缓存管理。
```js
const LRU = require('lru-cache')
const cache = new LRU({
  max: 500, // 指定缓存大小
  length: function (n, key) { return n * 2 + key.length }
})
```
简单说下`LRU`，引用百度百科的原话: 
> LRU是Least Recently Used的缩写，即最近最少使用，是一种常用的[页面置换算法](https://baike.baidu.com/item/%E9%A1%B5%E9%9D%A2%E7%BD%AE%E6%8D%A2%E7%AE%97%E6%B3%95/7626091)，选择最近最久未使用的页面予以淘汰。该算法赋予每个[页面](https://baike.baidu.com/item/%E9%A1%B5%E9%9D%A2/5544813)一个访问字段，用来记录一个页面自上次被访问以来所经历的时间 t，当须淘汰一个页面时，选择现有页面中其 t 值最大的，即最近最少使用的页面予以淘汰。

下面很多对缓存资源的`增、删、改、查`都是基于`cache`进行。

## 拦截.js文件
vue项目中的入口文件是`main.js`，而`main.js`文件中一般第一行都是下面这行代码。所以首先就要对.js文件进行处理。
```js
import Vue from 'vue'
```
这里其实就是对`vue的引用`做的一个优化。先来看源代码
```js
 else if (req.path.endsWith('.js')) {
      const key = parseUrl(req).pathname // main.js
      let out = await tryCache(key) // 读取页面缓存

      if (!out) {
        // transform import statements
        const result = await readSource(req) // 读取文件资源，返回filepath、内容source、updateTime
        out = transformModuleImports(result.source) // 改变引用路径，从import vue 改变成 import /__modules/vue
        cacheData(key, out, result.updateTime) // 缓存
      }

      send(res, out, 'application/javascript') // 响应浏览器资源
    }
```
也就是拿到当前的`main.js`文件，然后**改变vue的引用路径**，如下
```js
// old
import vue from 'vue'
// new
import Vue from "/__modules/vue"
```
而转换函数`readSource`和`transformModuleImports`作用已经在注释中标注出了，内部就是使用了一些`node模块`和`正则`处理文件资源
## 拦截 import vue
既然转换了vue的引用，那这个`/__modules/vue`路径下的vue又怎么去获取呢？简单来说，`vue-dev-server`是通过拦截这个路径资源请求，从而做出资源更改，然后响应浏览器，返回正确的vue文件。
```js
  // 对/__modules/请求的拦截
  else if (req.path.startsWith('/__modules/')) {
      const key = parseUrl(req).pathname // '/__modules/vue'
      const pkg = req.path.replace(/^\/__modules\//, '') // vue

      // 这里打印出来out是vue缓存资源，第一次没缓存通过loadPkg加载vue
      let out = await tryCache(key, false)
      if (!out) {
        out = (await loadPkg(pkg)).toString()
        cacheData(key, out, false)
      }

      send(res, out, 'application/javascript')
    }
```
重点在于`loadPkg`这个模块是干嘛的，还是先看下源码
```js
const fs = require('fs')
const path = require('path')
const readFile = require('util').promisify(fs.readFile)

async function loadPkg(pkg) {
  if (pkg === 'vue') {
    const dir = path.dirname(require.resolve('vue')) // 返回vue目录
    const filepath = path.join(dir, 'vue.esm.browser.js') // 拼接路径
    // 返回vue的es module完整版本，可以直接用于浏览器
    return readFile(filepath)
  }
  else {
    // TODO
    // check if the package has a browser es module that can be used
    // otherwise bundle it with rollup on the fly?
    throw new Error('npm imports support are not ready yet.')
  }
}

exports.loadPkg = loadPkg
```
从源码中可以看到，这个函数作用是**当浏览器请求vue资源时，`vue-dev-server`将vue目录下的`vue.esm.browser.js`返回给浏览器。**。而这个`vue.esm.browser.js`文件，从名字就能看出来是在浏览器中工作的，通过[官方文档](https://cn.vuejs.org/v2/guide/installation.html)也能印证猜想。这个文件不需要编译，浏览器直接就能使用。这样优化了对vue资源的请求。并且第二次访问资源时，是直接通过`tryCache`函数从缓存中拿。不仅是vue文件，`vue-dev-server`中所有处理过后的资源文件都是缓存在内存中的，第二次直接从内存中拿。具体可以查看[cache](##cache)

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/631bd66f6d9f4e809a20508d48ded7cc~tplv-k3u1fbpfcp-watermark.image?)

## 拦截 .vue文件
处理了`main.js`过后，之后就是对`.vue文件`的处理了。主要是通过`@vue/component-compiler`这个包
### @vue/component-compiler
`.vue`文件浏览器是不可识别的，所以就需要这个编译器，将`.vue`单文件转化为浏览器可识别的`js文件`。[github文档](https://github.com/vuejs/vue-component-compiler)

#### compiler.createDefaultCompiler
获取编译器实例
```js
const compiler = vueCompiler.createDefaultCompiler()
```

#### compiler.compileToDescriptor(filename: string, source: string)
参数为文件地址以及源代码内容，根据源代码编译输出每个模块，然后输出如下格式
```ts
interface DescriptorCompileResult {
  customBlocks: SFCBlock[]
  scopeId: string
  script?: CompileResult
  styles: StyleCompileResult[]
  template?: TemplateCompileResult & { functional: boolean }
}
// script编译后内容
interface CompileResult {
  code: string
  map?: any
}
// style编译后内容
interface StyleCompileResult {
  code: string
  map?: any
  scoped?: boolean
  media?: string
  moduleName?: string
  module?: any
}
// template模板编译后内容
interface TemplateCompileResult {
  code: string;
  source: string;
  tips: string[];
  errors: string[];
  functional: boolean;
}
```
上面的`template`、`script`、`styles`也就是vue文件中模板编译过后的返回内容，再查看当前`text.vue`文件输出，可知道上面`DescriptorCompileResult`中的我们关心的各个返回参数的内容

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/389b9b576677488dbee04526f0612f1e~tplv-k3u1fbpfcp-watermark.image?)
拷贝出来内容如下

`template`
```js
'var render = function() {\n  var _vm = this\n  var _h = _vm.$createElement\n  var _c = _vm._self._c || _h\n  return _c("div", [_vm._v(_vm._s(_vm.msg))])\n}\nvar staticRenderFns = []\nrender._withStripped = true\n'
```
`script`
```js
'//\n//\n//\n//\n\nexport default {\n  data() {\n    return {\n      msg: 'Hi from the Vue file!'\n    }\n  }\n}\n'
```

`styles`中的code
```js
'\ndiv[data-v-a941da2c] {\n  color: red;\n}\n'
```
通过这些编译后的js，应该可以大致理解`@vue/component-compiler`的作用了，**也就是将vue文件中的template、script、style转化为浏览器能识别的js**

### vueCompiler.assemble()
`assemble` 组装输出，会将之前编译的template、script、style组装成一个字符串，返回的是一个对象`{ code: string, map?: any }`。然后通过send方法响应给浏览器。
```js
  function send(res, source, mime) {
    res.setHeader('Content-Type', mime)
    res.end(source)
  }
  send(res, out.code, 'application/javascript')
```

### base64注入的作用
在通过`vueCompiler.assemble`合并模块时，对`script、style`重新做了处理。
```js
const assembledResult = vueCompiler.assemble(compiler, filepath, {
      ...descriptorResult,
      // 这里是重新为script和style中的内容注入了一段base64注释
      script: injectSourceMapToScript(descriptorResult.script),
      styles: injectSourceMapsToStyles(descriptorResult.styles)
    })
    return { ...assembledResult, updateTime }
}
function injectSourceMapToScript (script) {
    return injectSourceMapToBlock(script, 'js')
}

function injectSourceMapsToStyles (styles) {
    return styles.map(style => injectSourceMapToBlock(style, 'css'))
}
```
那么这个`injectSourceMapToBlock`有什么作用呢?查看源代码
```js
function injectSourceMapToBlock (block, lang) {
  const map = Base64.toBase64(
    JSON.stringify(block.map)
  )
  let mapInject

  switch (lang) {
    case 'js': mapInject = `//# sourceMappingURL=data:application/json;base64,${map}\n`; break;
    case 'css': mapInject = `/*# sourceMappingURL=data:application/json;base64,${map}*/\n`; break;
    default: break;
  }
  return {
    ...block,
    code: mapInject + block.code
  }
}
```
简单来说就是为之前转化的script和style注入了一段base64注释，也就是下面这样
```js
// js注入的注释
//# sourceMappingURL=data:application/json;base64, mapData
// css注入的注释
/*# sourceMappingURL=data:application/json;base64, mapData */
```
而其中的`mapData`就是将`script`和`style`中的`source code`转化成的`base64`。可以通过解码的形式拿到源文件代码。比如下面这段
```json
eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIkQ6XFxjb2RlXFxkZW1vXFxzb3VyY2VDb2RlXFx2dWUtZGV2LXNlcnZlci1hbmFseXNpc1xcdnVlLWRldi1zZXJ2ZXJcXHRlc3RcXHRlc3QudnVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFlQTtFQUNBLFVBQUE7QUFDQSIsImZpbGUiOiJ0ZXN0LnZ1ZSIsInNvdXJjZXNDb250ZW50IjpbIjx0ZW1wbGF0ZT5cbiAgPGRpdj57eyBtc2cgfX08L2Rpdj5cbjwvdGVtcGxhdGU+XG5cbjxzY3JpcHQ+XG5leHBvcnQgZGVmYXVsdCB7XG4gIGRhdGEoKSB7XG4gICAgcmV0dXJuIHtcbiAgICAgIG1zZzogJ0hpIGZyb20gdGhlIFZ1ZSBmaWxlISdcbiAgICB9XG4gIH1cbn1cbjwvc2NyaXB0PlxuXG48c3R5bGUgc2NvcGVkPlxuZGl2IHtcbiAgY29sb3I6IHJlZDtcbn1cbjwvc3R5bGU+XG4iXX0=
```
然后可以到[base64解码](http://tool.haooyou.com/code?group=ende&type=base64&action=de&charset=UTF-8)去进行解码查看内容

![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ee551d822565458887fcb7484e73a7ce~tplv-k3u1fbpfcp-watermark.image?)

有没有猜出来是干嘛用的？既然都能拿到vue文件中的`template`、`script`、`style`，就可以进行sourcemap输出了呀。因为浏览器本身是识别不了vue文件的，但是我们又看不懂编译过后的文件，所以`chrome`的`devtool`对这里做了特殊处理。`devtool`会将`//# sourceMappingURL`作为特殊注释，自动生成sourceMap文件。方便我们查看。

通过删除这段注释也能发现`source`资源中的文件变少了


![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/050966e81b32454eb58c1e2e62d1f8c2~tplv-k3u1fbpfcp-watermark.image?)

而加上`//# sourceMappingURL base64`注释，则又自动生成了文件。
![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e49573710d10445bbe29fb533f881145~tplv-k3u1fbpfcp-watermark.image?)

在chrome devtool文档上也找到了具体的说明

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5c03889eb54449b091b7b50f0aa521e2~tplv-k3u1fbpfcp-watermark.image?)

而`/*# sourceMappingURL`是 `Source Map V3`的标准

最新的可以使用`//# sourceURL=source.coffee`

# 总结
`vite-dev-serve`内部是通过`express`启动了一个服务器，然后通过中间件`vueMiddleware`对资源文件进行处理，先是获取`main.js`，通过拦截对`vue`的资源请求，改变返回的资源为`vue.esm.browser.js`，因为它是能直接在浏览器中访问。之后对`.vue`文件进行编译，将浏览器识别不了的vue文件中的`template` `script` `style`通过`@vue/component-compiler`这个包进行各个模块编译，最后通过编译器的`assemble`方法组装编译过后的`template、script、style`，组装的同时还做了`base64`注入处理，方便chrome做`sourceMap`，最后将资源文件响应给浏览器。并且这些资源都进行了缓存处理，缓存是缓存在内存中。

# 参考
[尤雨溪几年前开发的“玩具 vite”，才100多行代码，却十分有助于理解 vite 原理](https://juejin.cn/post/7021306258057592862#heading-7)

[Chrome devtool Map Preprocessed Code to Source Code](https://developer.chrome.com/docs/devtools/javascript/source-maps/)

[vue-component-compiler](https://github.com/vuejs/vue-component-compiler)

[vue对不同构建版本的解释](https://cn.vuejs.org/v2/guide/installation.html)

