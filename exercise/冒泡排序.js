const sort = (arr) => {
  if (!arr) return arr
  let flag = false
  for (let i = 0; i < arr.length; i++) {
    let k = 0
    while(k < arr.length - 1 - i) {
      if (arr[k] > arr[k + 1]) {
        arr = exchange(arr, k, k + 1)
        // 只要发生了一次交换，就修改标志位
        flag = true
      }
      k++
    }
    // 若一次交换也没发生，则说明数组有序，直接放过
    if (!flag) return arr
  }
  
  return arr
}
const exchange = (arr, i, j) => {
  [arr[i], arr[j]] = [arr[j], arr[i]]
  return arr
}

console.log(sort([5,4,3,2,1]))