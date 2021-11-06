// 自顶向下归并排序

let arr = [0, 2, 4, 2, 3, 1]


function sort(arr) {
  let len = arr.length
  if (len === 1) return arr
  let mid = Math.floor(len / 2) // 数组的中间位置
  let left = arr.splice(0, mid) // 截取前半段
  let right = arr // 剩余后半段
  return merge(sort(left), sort(right)) // 先sort拆分数组，再merge合并数组
}
function merge(left, right) {
  let tempArr = []
  while(left.length > 0 && right.length > 0) {
    if (left[0] <= right[0]) {
      tempArr.push(left.shift())
    } else {
      tempArr.push(right.shift())
    }
    console.log(tempArr)
  }

  while(left.length) {
    tempArr.push(left.shift())
  }
  while(right.length) {
    tempArr.push(right.shift())
  }
  return tempArr
}

console.log(sort(arr))

