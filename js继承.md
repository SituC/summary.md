定义父类
```javascript
function Person(name, age) {
  this.name = name
  this.age = age
}
Person.prototype.sayHi = function() {
  console.log(`I'm ${this.name} and i'm ${this.age} years old`)
}
const p = new Person('lwl', 27)
p.sayHi() // I'm lwl and i'm 27 years old
```

原型继承
```js
function Teacher() {}
Teacher.prototype = new Person('B', 26)
Teacher.prototype.constructor = Teacher

var t = new Teacher()
t.sayHi()
console.log(t instanceof Person) // true
console.log(t instanceof Teacher) // true
```