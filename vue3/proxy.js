const data = {
  name: 'zhangsan',
  age: 18
}

const proxyData = new Proxy(data, {
  get(target, key, receiver) {
    
  }
})