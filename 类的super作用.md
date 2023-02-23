在JavaScript中，super关键字用于调用父类的构造函数、静态方法或原型方法。在类的构造函数中，super()用于调用父类的构造函数，以便继承父类的属性和方法。在子类的方法中，使用super关键字可以调用父类的同名方法，同时可以使用super关键字调用父类的原型方法和静态方法。

在子类的构造函数中使用super()调用父类的构造函数，可以继承父类的属性和方法，同时也可以在子类中添加新的属性和方法。例如：

```js
class Animal {
  constructor(name) {
    this.name = name;
  }
  
  speak() {
    console.log(`${this.name} makes a noise.`);
  }
}

class Dog extends Animal {
  constructor(name, breed) {
    super(name);
    this.breed = breed;
  }
  
  speak() {
    super.speak();
    console.log(`${this.name} barks.`);
  }
}

const dog = new Dog('Fido', 'Labrador');
dog.speak(); // Fido makes a noise. Fido barks.

```