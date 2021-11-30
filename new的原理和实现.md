# 定义
`new`运算符创建一个用户定义的对象类型的实例或具有构造函数的内置对象的实例

## 构造函数体不同
构造函数也是函数，其唯一的区别就是调用方式不同，任何函数只要使用`new`操作符调用就是构造函数，而不使用`new`操作符调用的函数就是普通函数。

因此，构造函数也可以带有返回值，但是这会导致`new`的结果不同。

`无返回值`
```js
function Person(name) {
  this.name = name
}
let obj = new Person('jalen')
console.log(obj) // {name: 'jalen'}
```

`返回对象`
```js
function Person(age) {
  this.age = age
  return { name: 'jalen' }
}
let obj = new Person(18)
console.log(obj) // {name: 'jalen'}
```

打印的是{name:'Jalenl'}，也就是说return之前的定义都被覆盖了。这里return的是一个对象，那返回的是个**基本类型**呢？

`返回非对象`
```js
function Person(age) {
  this.age = age
  return 1
}
let obj = new Person(18)
console.log(obj) // {age: 18}
```
返回`{age: 18}`，这么说`return`失效了，那如果没有`this`绑定内部属性，再返回基本数据类型呢
`没有属性绑定+返回非对象`
```js
function Person() {
  return 1
}
new Person()
```
返回的是一个空对象`{}`，意料之中

**综上，只有构造函数return返回的是一个对象类型时，才能改变初始结果。**

## 构造函数类型不同
`构造函数为普通函数`

创建步骤：
1. 在内存中创建一个新对象
2. 这个新对象内部的`Prototype`特性被赋值为构造函数
3. 构造函数内部的`this`被赋值为这个新对象（即`this`指向新对象）
4. 执行构造函数内部的代码（给新对象添加属性）
5. 如果构造函数返回对象，则返回对象；否则，返回刚创建的新对象（空对象）

第五步就已经说明了构造函数不同导致new结果不同的原因。

以下摘自`MDN`的解释
>当代码 new Foo(...)执行时，会发生以下事情：
1. 一个继承自 Foo.prototype 的新对象被创建
2. 使用指定的参数调用构造函数 Foo，并将this绑定到新创建的对象。new Foo等同于 new Foo()，也就是没有指定参数列表，Foo不带任何参数调用的情况
3. 由构造函数返回的对象就是new表达式的结果。如果构造函数没有显示返回一个对象，则使用步骤1创建的对象（一般情况下，构造函数不返回值，但是用户可以选择主动返回对象，来覆盖正常的对象创建步骤）

`构造函数为箭头函数`
普通函数创建时，引擎会按照特定的规则为这个函数创建一个`prototype`属性（指向原型对象）。默认情况下，所有原型对象自动获得一个名为`constructor`属性，指回与之关联的构造函数
```js
function Person(){
    this.age = 18;
}
Person.prototype
/**
{
    constructor: ƒ Foo()
    __proto__: Object
}
**/
```
创建箭头函数时，**引擎不会为其创建prototype属性，箭头函数没有constructor供new调用**，因此使用new调用箭头函数会报错！

```js
const Person = ()=>{}
new Person()//TypeError: Foo is not a constructor
```
## 手写new
实现原理：
- 让实例可以访问到私有属性
- 让实例可以访问构造函数原型（constructor.prototype）所在原型链上的属性
- 构造函数返回的最后结果是引用类型

```js
function _new(constructor, ...ages) {
  // 构造函数类型合法判断
  if (typeof constructor !== 'function') {
    throw new Error('constructor must be a function')
  }
  // 新建对象实例
  let obj = new Object()
  // 设置原型链
  obj.__proto__ = Object.create(constructor.prototype)
  // 改变obj的this指向constructor
  let res = constructor.apply(obj, args)
  let isObject = typeof res === 'object' && res !== null
  let isFunction = typeof res === 'function'
  // 如果返回值且返回值是对象类型，那么就将它作为返回值，否则就返回之前新建的对象
  return isObject || isFunction ? res : obj
}

```

# 参考：
[new原理和实现](https://juejin.cn/post/6994000994300330021?utm_source=gold_browser_extension)