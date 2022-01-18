// 又叫观察者模式

// 发布基类
class Publisher {
  constructor() {
    this.observes = [] // 订阅发布
  }
  add (ob) {
    if (!this.observes.includes(ob)) {
      this.observes.push(ob)
    } else {
      throw new Error('Can\'t add the observe which has existed')
    }
  }
  remove (ob) {
    const index = this.observes.indexOf(ob)
    if (index) {
      this.observes.splice(index, 1)
    }
  }
  notify () {
    this.observes.forEach(item => {
      if (item.update) {
        item.update(this)
      }
    })
  }
}

// 订阅基类
class Observe {
  constructor() {
  }
  update() {
  }
}

// 业务发布类
class MyPublisher extends Publisher{
  constructor() {
    super()
    
  }
}