const debounce = (fn, wait = 500) => {
  let timer = null
  return function() {
    clearTimeout(timer)
    timer = setTimeout(() => {
      fn.apply(this, arguments)
    }, wait)
  }
}

const trottle = (fn, wait = 500) => {
  let prev = 0
  return function (...args) {
    let now = +new Date()
    if (now - prev < wait) {
      prev = now
      newFn.apply(this, args)
    }
  }
}

// 可以控制第一次点击和最后一次点击立即触发
function throttle2(func, wait = 500, options = {}) {
  let timeout, previous = 0
  return function (...args) {
    let now = +new Date()
    let remain = wait - (now - previous)

    if (remain < 0) {
      if (previous === 0 && !options.begin) {
        preview = now
        return
      }
      if (timeout) {
        clearTimeout(timeout)
        timeout = null
      }
      previous = now
      func.apply(this, args)
    } else if (!timeout && options.end) {
      timeout = setTimeout(() => {
        func.apply(this, args)
        timeout = null
      }, wait)
    }
  }
}