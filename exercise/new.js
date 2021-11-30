function _new(constructor, ...args) {
  if (typeof constructor !== 'function') {
    throw new Error('constructor must be a function')
  }
  // 创建新对象
  let obj = new Object()
  // 将原型链指向constructor的prototype
  obj.__proto__ = Object.create(constructor.prototype)
  // 执行构造函数并改变this
  let res = constructor.apply(obj, args)
  
  const isObject = typeof res === 'object' && res !== null
  const isFunction = typeof res === 'function'
  return isObject || isFunction ? res : obj
}