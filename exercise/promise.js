const FULFILLED = 'fulfilled'
const REJECTED = 'rejected'
const PENDING = 'pending'

class MyPromise {
  constructor(fn) {
    try {
      fn(this.resolve, this.reject)      
    } catch (error) {
      this.reject(error)
    }
  }
  value = null
  reason = null
  status = PENDING
  onFulfilledCallback = []
  onRejectedCallback = []
  resolve(value) {
    if (this.status === PENDING) {
      this.status = FULFILLED
      this.value = value
      while(this.onFulfilledCallback.length) {
        this.onFulfilledCallback.shift()(value)
      }
    }
  }
  reject(reason) {
    if (this.status === PENDING) {
      this.status = REJECTED
      this.reason = reason
      while(this.onRejectedCallback.length) {
        this.onRejectedCallback.shift()(reason)
      }
    }
  }
  then(onFulfilled, onRejected) {
    onFulfilled = typeof onFulfilled === 'function' ? onFulfilled : value => value
    onRejected = typeof onRejected === 'function' ? onRejected : error => {throw error}

    const nextPromise = new MyPromise((resolve, reject) => {
      if (this.status === FULFILLED) {
        queueMicrotask(() => {
          try {
            const x = resolve(this.value)
            resolvePromise(nextPromise, x, resolve, reject)
          } catch (error) {
            reject(error)
          }
        })
      } else if (this.status === REJECTED) {
        queueMicrotask(() => {
          try {
            const x = reject(this.reason)
            resolvePromise(nextPromise, x, resolve, reject)
          } catch (error) {
            reject(error)
          }
        })
      } else {
        this.onFulfilledCallback.push(onFulfilled)
        this.onRejectedCallback.push(onRejected)
      }
    })
  }
  catch(onRejected) {
    return this.then(undefined, onRejected)
  }
  finally(cb) {
    return this.then(
      value => this.resolve(cb()).then(() => value),
      reason => this.reject(cb()).then(() => {throw reason})
    )
  }
  static resolve(parameter) {
    if (parameter instanceof MyPromise) {
      return parameter
    }
    return new MyPromise(resolve => {
      resolve(parameter)
    })
  }
  static reject(reason) {
    return new MyPromise((resolve, reject) => {
      reject(reason)
    })
  }
}
const resolvePromise = (nextPromise, x, resolve, reject) => {
  if (nextPromise === x) {
    return reject(new TypeError('error'))
  }
    if (x instanceof MyPromise) {
      x.then(resolve, reject)
    } else {
      resolve(x)
    }
}


MyPromise.all = (lists) => {
  return new MyPromise((resolve, reject) => {
    let resArr = []
    let index = 0
    const processData = (i, data) => {
      resArr[i] = data
      index += 1
      if (index === lists.length) {
        resolve(resArr)
      }
    }
    for (let i = 0; i < lists.length; i++) {
      if (lists[i] instanceof MyPromise) {
        lists[i].then(data => {
          processData(i, data)
        }, err => {
          reject(err)
          return
        })
      } else {
        processData(i, lists[i])
      }
    }
  })
}

MyPromise.race = (lists) => {
  return new Promise((resolve, reject) => {
    for (let i = 0; i < lists.length; i++) {
      if (lists[i] instanceof MyPromise) {
        lists[i].then(data => {
          resolve(data)
          return
        }, err => {
          reject(err)
          return
        })
      } else {
        resolve(lists[i])
      }
    }
  })
}

MyPromise.allSettled = (lists) => {
  return new MyPromise((resolve, reject) => {
    lists = Array.isArray(lists) ? lists : []
    let len = lists.length
    const argslen = len
    if (len === 0) return resolve([])
    let args = Array.prototype.slice.call(lists)
  })
}

module.exports = MyPromise