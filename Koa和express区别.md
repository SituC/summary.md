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
<img src="https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2019/10/16/16dd415630d2423c~tplv-t2oaga2asx-watermark.awebp">

- koa: 采用promise形式，不像express有两个layer层，koa只有一个，用一个middleWare数组维护中间件，中间件执行顺序是采用洋葱模型，通过middleMare下标判断当前中间件是哪个，当执行next时，通过下标+1递归执行middleWare的下一个中间件，如果出现异常则之后的中间件会被终止，直接reject出错误。然后再进行`handleRequest`通过`delegate`对路由事件进行委托，委托自定义的`request`,`response`。`request`和`response`又对node原生的req和res进行方法代理，自定义了方法。
```js
  // middleWare收集处理
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

```js
  // 先收集middleware，再执行路由拦截，执行方法
  callback() {
    const fn = compose(this.middleware);

    if (!this.listenerCount('error')) this.on('error', this.onerror);

    const handleRequest = (req, res) => {
      const ctx = this.createContext(req, res);
      return this.handleRequest(ctx, fn);
    };

    return handleRequest;
  }
```

<img src="https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/aa709ad09bc94c0895c2b9a1ef355926~tplv-k3u1fbpfcp-watermark.awebp">

koa还会对使用了 * yield函数进行特殊处理，也就是koa.convert。将generator函数yield的value转换成promise方法，这样就能一直next下去。通过co函数进行转换。
```js
function co(gen) {
  var ctx = this;
  var args = slice.call(arguments, 1);
  
  return new Promise(function(resolve, reject) {
    if (typeof gen === 'function') gen = gen.apply(ctx, args);
    if (!gen || typeof gen.next !== 'function') return resolve(gen);

    onFulfilled();
    
    function onFulfilled(res) {
      var ret;
      try {
        ret = gen.next(res);
      } catch (e) {
        return reject(e);
      }
      next(ret);
      return null;
    }

    function onRejected(err) {
      var ret;
      try {
        ret = gen.throw(err);
      } catch (e) {
        return reject(e);
      }
      next(ret);
    }

    function next(ret) {
      if (ret.done) return resolve(ret.value);
      var value = toPromise.call(ctx, ret.value);
      if (value && isPromise(value)) return value.then(onFulfilled, onRejected);
      return onRejected(new TypeError('You may only yield a function, promise, generator, array, or object, '
        + 'but the following object was passed: "' + String(ret.value) + '"'));
    }
  });
}
```