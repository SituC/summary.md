/**
 * 真题描述： 给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。
 * 给定 nums = [2, 7, 11, 15], target = 9
  因为 nums[0] + nums[1] = 2 + 7 = 9 所以返回 [0, 1]
  一旦联想到双重循环，一定要报着空间去换时间的想法
  也就是用数组或者map存储值
 */

function getIndex(arr, targetValue) {
  let map = {}
  let arr2 = []
  for (let i = 0; i < arr.length; i++) {
    const cur = arr[i]
    const j = targetValue - cur
    if (typeof map[cur] === 'number') {
      arr2 = [map[cur], i]
    } else {
      if (targetValue - cur > 0) {
        map[j] = i
      }
    }
  }
  return arr2
}

console.log(getIndex([2, 7, 11, 15], 17))
// map[7] = 0
