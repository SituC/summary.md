### setInterval 与 setTimeout的区别

- setInterval(fn, time): 每隔`time`ms 将 `fn函数`推送到任务队列
- setTimeout(fn, time): 倒计时time过后会直接将fn推送到任务队列中

也就是意味着，setInterval其实会被主进程中的程序给`影响`，假设有段程序耗时2s，那么setInterval推送进任务队列的时间就得是2s中过后，而setTimeout不受此影响。
```js
let startTime = new Date().getTime();
let count = 0;

setInterval(() => {
  let i = 0;
  while (i++ < 1000) { // 每次执行时都会被这段耗时程序所影响，每当下一次时间循环时，会发现上一次事件循环的setInterval还没结束（因为被耗时任务所影响了），这样也就不会进入下一次setInterval
    console.log(i)
  }; // 假设的网络延迟
  count++;
  console.log(
    "与原设定的间隔时差了：",
    new Date().getTime() - (startTime + count * 1000),
    "毫秒"
  );
}, 1000)

```

这样会造成setInterval与预想中的时间调用不一致，可以使用setTimeout来改写成setInterval
```js
let timer = null
function myInterval(func, wait) {
  let interv = function() {
    func.call(null)
    timer = setTimeout(interv, wait)
  }
  timer = setTimeout(interv, wait)
  return timer
}
// 调用
myInterval(function() {}, 20)
// 消除
if(timer){
  clearTimeout(timer)
  timer = null
}
```