// 1 普通的delay
const delay1 = (ms, value = {}) => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve(value)
    }, ms)
  })
}
// 使用
(async() => {
  const result = await delay1(1000, { value: 'lwl' });
  console.log('输出结果', result);
})();


// 2 带取消功能和随机时间返回的delay
// 使用了最新的api AbortController，
// AbortController，接口表示一个控制器对象，允许你根据需要中止一个或多个 Web 请求。
// 具体查看 https://developer.mozilla.org/zh-CN/docs/Web/API/AbortController
// 先说使用方法
(async () => {
  const abortController = new AbortController()
  setTimeout(() => {
    abortController.abort()
  }, 500)
  try {
    await delay(1000, { signal: abortController.signal })
  } catch (error) {
    console.log(error.name)
  }
})()

// 实现

// 先定义一个随机数生成器
const randomInteger = (minimum, maximum) => Math.floor((Math.random() * (maximum - minimum + 1)) + minimum)

const createAbortError = () => {
  const error = new Error('Delay aborted')
  error.name = 'AbortError'
  return error
}

const createDelay = ({ willResolve }) => (ms, { value, signal} = {}) => {
  if (signal && signal.aborted) {
    return Promise.reject(createAbortError())
  }
  let timeoutId
  let settle
  let rejectFn
  const signalListener = () => {
    clearTimeout(timeoutId)
    rejectFn(createAbortError)
  }
  const cleanup = () => {
    if (signal) {
      signal.removeEventListener('abort', signalListener)
    }
  }
  const delayPromise = new Promise((resolve, reject) => {
    settle = () => {
      cleanup()
      if (willResolve) {
        resolve(value)
      } else {
        reject(value)
      }
    }
    rejectFn = reject
    timeoutId = setTimeout(settle, ms)
  })
  if (signal) {
    signal.addEventListener('abort', signalListener, { once: true })
  }
  delayPromise.clear = () => {
    clearTimeout(timeoutId)
    timeoutId = null
    settle()
  }
  return delayPromise
}

const createWithTimer = () => {
  const delay = createDelay({ willResolve: true })
  delay.reject = createDelay({ willResolve: false })
  delay.range = (minimum, maximum, options) => delay(randomInteger(minimum, maximum), options)
  return delay
}
const delay = createWithTimer()