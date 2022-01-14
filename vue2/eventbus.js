class Bus {
  constructor() {
    this.callback = {}
  }
  $on(name, fn) {
    this.callback[name] = this.callback[name] || []
    this.callback[name].push(fn)
  }
  $emit(name, ...args) {
    if (this.callback[name]) {
      this.callback[name].forEach(fn => fn(...args))
    }
  }
}
// main.js
Vue.protoType.$bus = new Bus()

// children1
this.$bus.$emit('data')

// children2
this.$bus.$on('data', this.handler)
