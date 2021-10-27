`nextTick`在vue内部其实是按照 `promise、MutationObserver、setImmediate、setTimeout`的顺序来降级处理异步的。

执行顺序一般是 `nextTick > promise > setTimeout`，因为在`Vue`初始化时，nextTick就已经被初始化了，在使用nextTick时只是在往初始化的promise执行的事件栈中push事件。而业务逻辑的promise是一个新的promise，所以会造成nextTick比promise更快执行。但是也不是绝对的，可以通过`$nextTick().then(fn)`的形式让fn也在第二次promise执行时进行。因为promise的then就是新建一个promise。
```js
export function nextTick (cb?: Function, ctx?: Object) {
  let _resolve
  callbacks.push(() => { // 添加事件
    if (cb) {
      try {
        cb.call(ctx)
      } catch (e) {
        handleError(e, ctx, 'nextTick')
      }
    } else if (_resolve) {
      _resolve(ctx)
    }
  })
}

if (typeof Promise !== 'undefined' && isNative(Promise)) {
  const p = Promise.resolve()
  timerFunc = () => {
    p.then(flushCallbacks) // 执行
    if (isIOS) setTimeout(noop)
  }
  isUsingMicroTask = true
}
```
