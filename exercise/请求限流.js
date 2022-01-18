// 请求限流
// 最大并发2个请求
class Schedule {
  cacheFetchArr = []
  currentIndex = 0
  constructor(limit = 2) {
    this.maxLimit = limit
  }
  async add(myFetch) {
    cacheFetchArr.push(myFetch)
    this.fetch()
  }
  async fetch() {
    if (this.currentIndex > this.maxLimit) {
      return
    }
    ++this.currentIndex
    await this.cacheFetchArr.shift()
    --this.currentIndex
    if (this.cacheFetchArr.length) {
      this.fetch()
    }
  }
}

let timeout = (data) => {
  return new Promise().resolve(data)
}

let getData = (data) => {
  let schedule = new Schedule()
  schedule.add(timeout)
}

getData(1)
getData(2)
getData(3)
getData(4)