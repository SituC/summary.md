const PENDING = 'pending'
const FULFILLED = 'fulfilled'
const REJECTED = 'rejected'

class MyPromise {
  constructor(executor) {
    // executor是一个执行器，进入会立即执行
    // 传入resolve和reject
    // 检测传入的代码体出错
    try {
      executor(this.resolve, this.reject)
    } catch (error) {
      this.reject(error)      
    }
  }

  // 为实例定义属性 status、value、reason
  // 存储状态码变量，初始值是pending
  status = PENDING
  // 成功之后的值
  value = null
  // 失败之后的原因
  reason = null
  // 存储成功回调函数
  onFulfilledCallback = []
  // 存储失败回调函数
  onRejectedCallback = []

  // 箭头函数让方法内部this指向当前实例
  // 更改成功后的状态
  resolve = (value) => {
    // 只有状态时等待，才执行状态修改
    if (this.status === PENDING) {
      // 状态修改成功
      this.status = FULFILLED
      // 保存成功的值
      this.value = value
      // 判断回调函数是否存在，有则调用
      while(this.onFulfilledCallback.length) {
        this.onFulfilledCallback.shift()(value)
      }
    }
  }
  // 同理响应失败流程
  reject = (reason) => {
    if (this.status === PENDING) {
      this.status = REJECTED
      this.reason = reason
      while(this.onRejectedCallback.length) {
        this.onRejectedCallback.shift()(reason)
      }
    }
  }

  then(onFulfilled, onRejected) {
    // 如果不传，就使用默认函数
    onFulfilled = typeof onFulfilled === 'function' ? onFulfilled : value => value;
    onRejected = typeof onRejected === 'function' ? onRejected : reason => {throw reason};

    // 为了链式调用创建一个MyProise并在后面return出去
    const nextPromise = new MyPromise((resolve, reject) => {
      // 这里的内容在执行器中，会立即执行
      if (this.status === FULFILLED) {
        // 创建一个微任务等待 promise2 完成初始化
        queueMicrotask(() => {
          try {
            // 获取成功回调函数的执行结果
            const x = onFulfilled(this.value)
            // 传入 resolvePromise 集中处理
            resolvePromise(nextPromise, x, resolve, reject)
          } catch (error) {
            reject(error)            
          }
        })  
      } else if (this.status === REJECTED) {
        queueMicrotask(() => {
          try {
            const x = onRejected(this.reason)
            resolvePromise(nextPromise, x, resolve, reject)
          } catch (error) {
            reject(error)
          }
        })
      } else if (this.status === PENDING) {
        // 当promise中是异步时，并未进行状态的变更，此时then还是pending状态
        // 此时将回调暂时存储起来
        this.onFulfilledCallback.push(onFulfilled)
        this.onRejectedCallback.push(onRejected)
      }
    })
    return nextPromise
  }

  // 直接Promise.resolve
  // 定义静态属性
  static resolve(parameter) {
    // 如果传入promise直接返回
    if (paramter instanceof MyPromise) {
      return parameter
    }
    // 转成常规方式
    return new MyPromise(resolve => {
      resolve(parameter)
    })
  }

  // 定义reject
  static reject(reason) {
    return new MyPromise((resolve, reject) => {
      reject(reason)
    })
  }
}

const resolvePromise = (nextPromise, x, resolve, reject) => {
  // 如果相等了，说明return的是自己，抛出类型错误并返回
  if (nextPromise === x) {
    return reject(new TypeError('Chaining cycle detected for promise #<Promise>'))
  }
  // 判断x是不是promise对象
  if (x instanceof MyPromise) {
    // 执行x，调用then方法，目的是将其状态改变为fulfilled或者rejeacted
    // x.then(value => resolve(value), reason => reject(reason))
    x.then(resolve, reject)
  } else {
    resolve(x)
  }
}

module.exports = MyPromise