# 用途
一般用来指定this的环境

```js
var a = {
    user:"追梦子",
    fn:function(){
        console.log(this.user);
    }
}
var b = a.fn;
b(); //undefined
```
我们是想打印对象a里面的user却打印出来undefined是怎么回事呢？如果我们直接执行a.fn()是可以的。


1. call()

```js
var a = {
    user:"追梦子",
    fn:function(){
        console.log(this.user); //追梦子
    }
}
var b = a.fn;
b.call(a);
```