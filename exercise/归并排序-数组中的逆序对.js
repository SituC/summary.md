/**
 * 
 * @param {*} arrs 数组
 * @param {*} l 左边界下标
 * @param {*} r 右边界下标
 */
const merge_sort = function(arrs, l, r) {
  if (l >= r) return 0 // 左右边界重合说明只剩一个元素
  let result = 0,
    middle = (l + r) >> 1// 计算左右中间值

  result += merge_sort(arrs, l, middle), // 获取左半部分逆序对个数
  result += merge_sort(arrs, middle + 1, r); // 获取右半部分逆序对个数

  let temp = [] // 创建一个存储空间，用于合并已排好序的数组
  // 指定左右两边起始位置
  let p1 = l, p2 = middle + 1

  // 循环条件：左边不为空或右边不为空
  while(p1 <= middle || p2 <= r) {
    // 右边不存在或左边元素存在且值小于右边， 
    // 将左边元素存入 tmp 中，并将下标往后走一位
    if (p2 > r || (p1 <= middle && arrs[p1] <= arrs[p2])) {
      temp.push(arrs[p1++])
    } else {
      temp.push(arrs[p2++])
      result += (middle - p1 + 1)
    }
  }

  // 覆盖arrs中下标l至r的元素
  for (let i = l; i <= r; i++) {
    arrs[i] = temp[i - l]
  }
  return result
}
var reversePairs = function(nums) {
  return merge_sort(nums, 0, nums.length - 1);
};
