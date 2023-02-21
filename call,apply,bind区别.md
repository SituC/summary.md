# 用途
一般用来指定this的环境

1. call(), apply() 立即执行，bind()要调用再执行

2. call()，apply()，bind()第一个参数后面参数的传递方式不一样了：

　　call()，bind()的第二个，第三个，第四个...参数,是用逗号隔开，传递的

　　apply() 需要把多个参数放在一个数组中，作为第二个参数传递

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