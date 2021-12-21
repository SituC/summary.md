const FULFILLED = 'fulfilled'
const REJECTED = 'rejected'
const PENDING = 'pending'
class myPromise {
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
      while(this.onFulfilledCallback.length) {
        this.onFulfilledCallback.shift()(reason)
      }
    }
  }
  then(onFulfilled, onRejected) {
    onFulfilled = typeof onFulfilled === 'function' ? onFulfilled : value => value
    onRejected = typeof onRejected === 'function' ? onRejected : error => {throw error}

    const nextPromise = new myPromise((resolve, reject) => {
      if (this.status === FULFILLED) {
        queueMicrotask(() => {
          try {
            const x = onFulfilled(this.value)
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
      } else {
        this.onFulfilledCallback.push(onFulfilled)
        this.onRejectedCallback.push(onRejected)
      }
    })
    return nextPromise
  }
  static resolve() {}
  static reject() {}
}

const resolvePromise = (nextPromise, x, resolve, reject) => {
  if (nextPromise === x) {
    return reject(new TypeError('Chaining cycle detected for promise #<Promise>'))
  }
  if (x instanceof myPromise) {
    x.then(resolve, reject)
  } else {
    resolve(x)
  }
}
