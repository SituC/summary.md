1. 图层初始化的模式

- express：采用嵌套模式，首先会创建框架中间件的layer，也就是app.use和router.use，再在中间件layer中创建路由的layer，也就是app.[httpMethods]、app.all、router.[httpMethods]、router.all。执行的顺序也就是先执行中间件layer，再递归执行中间件中的layer
```js
((req, res) => {
  console.log('I am the first middleware');
  ((req, res) => {
    console.log('I am the second middleware');
    (async(req, res) => {
      console.log('I am the router middleware => /api/test1');
      await sleep(2000)
      res.status(200).send('hello')
    })(req, res)
    console.log('second middleware end calling');
  })(req, res)
  console.log('first middleware end calling')
})(req, res)

```

- koa: 采用promise形式，不像express有两个layer层，koa只有一个，用一个middleWare数组维护中间件，中间件执行顺序是采用洋葱模型，通过middleMare下标判断当前中间件是哪个，当执行next时，通过下标+1递归执行middleWare的下一个中间件，如果出现异常则之后的中间件会被终止，直接reject出错误。
```js
  return function (context, next) {
    // last called middleware #
    let index = -1
    return dispatch(0)
    function dispatch (i) {
      if (i <= index) return Promise.reject(new Error('next() called multiple times'))
      index = i
      let fn = middleware[i]
      if (i === middleware.length) fn = next
      if (!fn) return Promise.resolve()
      try {
        return Promise.resolve(fn(context, function next () {
          return dispatch(i + 1)
        }))
      } catch (err) {
        return Promise.reject(err)
      }
    }
  }
```