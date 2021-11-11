/**
 * 真题描述：给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有满足条件且不重复的三元组。
 * 注意：答案中不可以包含重复的三元组。
 * 
 * 给定数组 nums = [-1, 0, 1, 2, -1, -4]， 
 * 满足要求的三元组集合为： [ [-1, 0, 1], [-1, -1, 2] ]
 */
let arr = [-1, 0, 1, 2, -1, -3]
function sort(arr) {
  arr = arr.sort((a, b) => a - b)
  let arr2 = []
  // let i = 0, k = i + 1, j = arr.length - 1
  let len = arr.length
  for (let i = 0; i < len - 2; i++) {
    let k = i + 1
    let j = len - 1
    // 排除重复的
    if (i >= 0 && arr[i] === arr[i - 1]) {
      continue
    }
    while(k < j) {
      let temp = arr[i] + arr[k] + arr[j]
      if (temp > 0) {
        j--
      } else if (temp < 0) {
        k++
      } else {
        let k2 = [arr[i], arr[k], arr[j]]
        i++
        k = i + 1
        j = arr.length - 1
        arr2.push(k2)
      }
    }
  }
  return arr2
}

console.log(sort(arr))