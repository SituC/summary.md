# 创建应用
```js
const express = require('express')
const app = express()
```
# app相关API
### 1. app.set(name, value)
`name`可以自己定义，也可以定义`应用配置`， [应用配置参数参考](https://www.cnblogs.com/ouzilin/p/7906089.html)
```js
// 应用配置
app.set('env', 'production')
// 自定义配置
app.set('age', 18)
```

### 2. app.get(name)
获取设置的属性值
```js
app.get('age') // 18

app.get('env') // production
```

### 3. app.enable(name)
用于将设置项name的值设为true
```js
app.enable('isopen')
app.get('isopen') // true
```

### 4. app.disable(name)
用于将设置项name的值设为false
```js
app.disable('isopen')
app.get('isopen') // false
```

### 5. app.enabled(name)
用于检查设置项name的值是否为true
```js
app.enabled('isopen')
```

### 6. app.disabled(name)
用于检查设置项name的值是否为false
```js
app.disabled('isopen')
```

### 7. app.listen(port)
app.listen(path, [callback])

app.listen([port, host, backlog][callback])
```js
app.listen(8080, () => {
  console.log('port listen 8080')
})
```

### 8. app.use()
用于使用 express 相关中间件

app.use(path,callback)中的`callback`既可以是`router对象`又可以是`函数`

app.get(path,callback)中的`callback`只能是`函数`

当一个路由有好多个子路由时用`app.use(path,router)`

```js
app.use((req,res,next) => {
    console.log("req.method ->",req.method)
    next()
})
// 使用router模块化管理路由
const router = require('./homeRouter.js')

app.use('/home/', router)

// homeRouter.js
var express = require('express')
var router = express.Router()
router.get("/",(req,res)=>{
    res.send("/")
})
router.get("/one",(req,res)=>{
    res.send("one")
})
router.get("/second",(req,res)=>{
    res.send("second")
})
router.get("/treen",(req,res)=>{
    res.send("treen")
})
module.exports = router;
```

# request 相关API

### 1 req.params

获取`/user/:id`参数，这是一个数组对象，命名过的参数会以键值对的形式存放。如有一个路由 /user/:id，那么 "id" 属性会存放在 req.param.id 中，而这个对象默认为 {}。对应的还有一个 api 是 req.param(name)，则会返回对应 name 参数的值
```js
// 路由
app.post('/home/:ids')
// 前端请求url
'localhost:3000/home/ids=123'
```
### 2 req.query
获取`query`参数，这是一个解析过的请求参数对象，默认为{}，如有一个路由 /detail/id=123，那么 req.query.id 的值就为 123.

### 3 req.body
解析`body`参数，需要配置parser解析
```js
// 配置parser
app.use(express.json())
app.use(express.urlencoded({ extended: false }))
// 获取body参数
app.post('/home', (req, res) => {
  console.log(req.body) // [Object: null prototype] { id: '1234' }
})
```
### 4 req.route
这个对象里是当前匹配的 Route 里包含的属性，包括原始路径字符串、产生的正则、method、查询参数等
```js
route Route {
  path: '/home',
  stack: [
    Layer {
      handle: [Function],
      name: '<anonymous>',
      params: undefined,
      path: undefined,
      keys: [],
      regexp: /^\/?$/i,
      method: 'post'
    }
  ],
  methods: { post: true }
}
```
### 5 req.cookies

使用 cookieParaser() 中间件后该对象默认为 {}，也包含用户代理传过来的 cookies。

### 6 req.get(field)

获取请求头里的 field 的值，注意是大小写不敏感的，其中 referrer 和 referer 字段是可以互换的。例如 req.get("Content-Type")。

### 7 req.accepts(types)
确定客户端是否接受一个或一组指定的类型（可选类型可以是单个的 MIME 类型，如 `application/json` 、一个`逗号分隔集合`或是一个`数组`），当可以接受时返回最匹配的，否则返回 false ，这个时候应该响应一个 406 "Not Acceptable"。 
```js
// 前端请求头配置 Accept:text/html
req.accepts("html")  // "html"
// Accept:text/*,application/json
req.accepts("html")  // "html"
req.accepts("text/html")  // "text/html"
req.accepts("json,text")  // "json"
req.accepts(['image/png', 'html']) // 只会返回允许的也就是 html
req.accepts("image/png")  // false
req.accepts("png")  // false

```

### 7 req.is(type)
检查请求的文件头是不是包含 "Content-Type" 字段，它匹配给定的 type。
```js
// Content-Type：text/html
req.is("html")  //true
req.is("text")  //true
req.is("text/html")  //true
req.is("json")  //false
req.is("application/json")  //false
```
### 8 req.path 
返回请求地址
### 9 req.host 
返回host请求头里取的`主机名`
### 10 req.protocol
返回请求协议 http or https

# response 相关 API

### 1 res.status(code)
`设置`相应的`http状态`，是node的response。statusCode的链式调用
```js
res.status(403).end()
res.status(400).send(Bad Request)
res.status(404).sendFile("/images/404.png")
```

### 2 res.set(field,[value])
设置响应头字段 field 值为 value，也可以一次传入一个对象设置多个值。
```js
res.set("Content-Type","text/plain")
res.set({
    "Content-Type":"text/plain",
    "Content-Length":"123",
    "ETag":"12345"
})
```

### 3 res.get(field)
返回一个大小写不敏感的响应头里的 field 的值
```js
res.get("Content-Type")  // "text/plain"

```
### 4 res.cookie(name,value,[options])
设置 `cookie` `name` 值为 `value`，接受字符串参数或者JSON对象。path属性默认为 "/"。 
```js
// 配置session
app.use(session({
  secret: 'keyboard cat', // 秘钥
  resave: false,
  saveUninitialized: true,
  // secure 限制浏览器发送cookie通过 https 发送到服务器，而不是普通的 http
  cookie: { secure: true }
  // httpOnly: true 仅允许网络访问，不允许js访问
}))
// 
res.cookie("name","mary",{domain:".baidu.com",path:"/index",secure:true})
res.cookie("cart",{items:[1,2,3]})
```

### 5 res.clearCookie(name,[options])
把 name 的 cookie 清除，path 参数默认为"/"。如 res.clearCookie("name",{path:"/index"})

### 6.res.redirect([status],url)
使用可选的状态码跳转到 url，状态码 status 默认为 `302 "Found"`。express 支持几种跳转，
- 第一种：使用一个完整的 URL 跳转到一个完全不同的网站，例 res.redirect("`baidu.com`")； 
- 第二种是根据相对根域路径跳转，如当前在 "`example.com`"， 则 res.redirect("`/detail`") 则是跳转到 "`example.com/detail`"。
- 第三种是路径名跳转，res.redirect("`..`")是跳转到上一级网页，如当前在 "`example.com/products/de…`"，那么则会跳转至 "`example.com/products`"
- res.redirect("`back`") 则是跳转到 `referer` 的地址，当 Referer 丢失的时候默认为 /

### 7 res.send([body|status],[body])
发送一个响应，这个方法在输出响应的时候会自动完成大量有用的任务，比如定义前面没有定义的 Content-Length，加一些自动的 HEAD等。当参数为一个 Buffer 时 Content-Type 会被设置为 "application/octet-stream"，当参数为 String 时 Content-Type 默认设置为 "text/html"，当参数为 Array 或 Object 时 Express 会返回一个 JSON，当参数为 Number 时，express 会自动设置一个响应体，比如 200 会返回字符"OK"，404会返回 "Not Found" 等等。

### 8 res.json([status|body],[body])
返回一个 JSON 响应。当 res.send() 的参数是一个对象或者数组的时候会调用这个方法，它在复杂的空值(null,undefined,etc)JSON转换的时候有用。
```js
res.json(null)
res.json({user:"mary"})
res.json(500,{error:"message"})
```
### 9.res.format(object)

设置特定请求头的响应，这个方法使用 req.accepted，执行第一个匹配的回调，当没有匹配时服务器会返回一个 406 "Not Acceptable" 或者执行 default 回调。
```js
res.format({
    "text/plain":function(){
        res.send("hi")
    },
    "text/html":function(){
        res.send("hey")
    },
    "application/json":function(){
        res.send({message:"boy"})
    }
})
```

# router 相关 API
创建路由
```js
var router = express.Router([options])
app.use('/hone', router)
```
### 1 router.all(path,[callback,...]callback)
会匹配所有的HTTP动作（`get`, `post`, `put` ...），对想映射全局的逻辑处理到特殊的`路径前缀`或者`任意匹配`是十分有用的，例如想要对从某个点开始的所有路由进行验证操作和自动加载用户信息，示例如下：
```js
router.all("*",requireAuthentication,loadUser)
// 仅仅作用于以api开头的路径
router.all("/api/*",requireAuthentication)
```

### 2 router.method(path,[callback,...]callback)
指的是router.get()，router.put()，router.post()等等，使用方式和router.all() 一样，若对匹配的path有特殊的限制，也可以使用正则表达式。 示例：
```js
router.get("/",function(req,res){
    res.send("hello world")
})
```

### 3.router.param(name,callback)
给路由参数添加回调触发器，`name` 指的是参数名，`function` 是回调方法，回调方法的参数依次是请求对象、响应对象、下个中间件、参数值和参数名，对于param的回调定义的路由来说，他们是局部的，不会被挂载的app或者路由继承，所以定义在router上的param回调只有是在`router上的路由具有这个路由参数时`才起作用。在定义param的路由上，param回调都是第一个被调用的，他们在一个请求-响应循环中都会被`调用一次并且只有一次`，即使多个路由都匹配。
```js
router.param("id",function(req,res,next,idValue){
  // idValue为参数值
  console.log("called only once")
})
router.get("/user/:id",function(req,res,next){
  console.log("although this matches")
  next()
})
router.get("/user/:id",function(req,res){
  console.log("and this matches too")
  res.end()
})
```
### 4 router.route(path)
回一个单例模式的路由的实例，之后可以在其上施加各种HTTP动作的中间件
```js
router.param('user_id', function(req, res, next, id) {
    req.user = {
        id:id,
        name:"TJ"
    };
    next();
});
router.route('/users/:user_id')
  .all(function(req, res, next) {
      next();
  })
  .get(function(req, res, next) {
      res.json(req.user);
  })
  .put(function(req, res, next) {
      req.user.name = req.params.name;
      res.json(req.user);
  })
  .post(function(req, res, next) {
      next(new Error('not implemented'));
  })
  .delete(function(req, res, next) {
      next(new Error('not implemented'));
  })
```

### 5 router.use([path],[function,...]function)
给可选的 path 参数指定的路径挂载给定的中间件方法，未指定 path 参数时默认为 /，类似于app.use()方法。

# 参考
[Express API 总结](https://juejin.cn/post/6988055925760213000?utm_source=gold_browser_extension)
