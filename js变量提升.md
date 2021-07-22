JavaScript程序执行是`自上而下`执行的

1
```js
console.log(a)
var a = 10
```
通过var声明的变量会变量提升到当前作用于最顶部，所以上面代码实际是
```js
var a
console.log(a) // undefined
a = 10
```

2
```js
console.log(a) // a is not defined
a = 10
```
没有通过var声明变量，直接`a = 10`赋值操作，没有变量提升，此时`console.log(a)`报错 `a is not defined`

3
```js
console.log(a) // a is not defined
let a = 10

if (true) {
  console.log(b) // 产生块作用于，b is not defined
}
let b = 100
```
通过`let`,`const`声明的变量不仅不会变量提升，而且还会形成块作用域，因此报错`a is not defined`

4
```js
var flag = true
if (flag) {
  var a = 10
}
console.log(a)
```
因为`var a = 10`发生变量提升，并且`if`语句没有作用域，所有程序都在同一个作用域`window`之下所以代码实际是
```js
var flag = true
var a
if (flag) {
  a = 10
}
console.log(a)
```
当flag为true的时候回输出10

当flag为false的时候输出`undefined`

5
```js
foo()
function foo() {
  console.log(a)
}
var a = 10
```
`var`发生变量提升，`函数声明整个函数发生变量提升`所以代码实际是
```js
var a
function foo() {
  conosle.log(a) // undefined
}
foo()
a = 10
```

6
```js
foo()
var foo = function() {
  console.log(a)
}
var a = 10
```
`函数式表达式 var foo = function...`会发生变量提升，所以实际为
```js
var foo
var a
foo() // 此时foo应该为undefined，因此输出 foo is not a function
foo = function() {
  console.log(a)
}
a = 10
```

7
```js
var a = 10

function foo() {
  console.log(a)
}

foo(a) // foo运行在全局作用域 输出10

function baz() {
  var a = 100
  foo() // foo运行在baz包裹的作用域，输出10，并不会输出离自己进的100
}

baz() 
```
在代码运行前（也就是`编译阶段`），作用域都已经确定好了。 foo永远在`全局作用域`下，不管他在哪里运行，foo都会输出全局作用域下的a

再看以下代码
```js
function ff() {
    console.log(b) // b is not defined
}

function kk() {
    var b = 100
    ff()
}
kk()
```
可以看出`ff`中的`b`和`kk`中的`b`没有任何关系，我们平时写代码也不会写出这样的代码，写代码时很明确这种写法不对，但是看问题的时候反而会被代入问题中，以至于做出错误的判断...值得反思呀


### 参考

[从作用域到变量提升](https://juejin.cn/post/6987661731858219016?utm_source=gold_browser_extension)

