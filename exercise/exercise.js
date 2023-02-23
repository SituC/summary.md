class Animal {
  constructor(name) {
    this.name = name
  }
  speak() {
    console.log(`${this.name} okokok`)
  }
}

class Dog extends Animal {
  name = ''
  constructor(name1, name2) {
    // super(name1)
    this.name = name2
  }
  speak() {
    // super.speak()
    console.log(`${this.name} okokok222`)
  }
}

const dog = new Dog('kkk', 'cccc')
dog.speak()