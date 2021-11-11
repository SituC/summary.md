let arr = [3,1,4,5,2,3,666,12,434,43,35,45,2242]

function sort (arr) {
  let len = arr.length
  for (let i = 0; i < len; i++) { // 外层循环用于控制从头到尾的比较+交换到底有多少轮
    // 内层循环用于完成每一轮遍历过程中的重复比较+交换
    // 因为最大要比较到 j + 1范围，所以 j < len - 1 - i
    for (let j = 0; j < len - i - 1; j++) {
      if (arr[j] > arr[j + 1]) {
        [arr[j], arr[j + 1]] = [arr[j+1], arr[j]]
      }
    }
  }
  return arr
}
console.log(sort(arr))