/**
 * 真题描述：给你两个有序整数数组 nums1 和 nums2，
 * 请你将 nums2 合并到 nums1 中，使 nums1 成为一个有序数组。

说明: 初始化 nums1 和 nums2 的元素数量分别为 m 和 n 。 
你可以假设 nums1 有足够的空间（空间大小大于或等于 m + n）来保存 nums2 中的元素。

输入:
nums1 = [1,2,3,0,0,0], m = 3
nums2 = [2,5,6], n = 3
输出: [1,2,2,3,5,6]

双指针法用在涉及求和、比大小类的数组题目里时，
大前提往往是：该数组必须有序。
否则双指针根本无法帮助我们缩小定位的范围，压根没有意义
 */

function mergeSort(arr1, m, arr2, n) {
  let l = m - 1, r = n - 1, k = m + n - 1
  while(l >= 0 && r >= 0) {
    if (arr2[r] >= arr1[l]) {
      arr1[k] = arr2[r]
      r--
      k--
    } else {
      arr1[k] = arr1[l]
      l--
      k--
    }
  }
  while(r >= 0) {
    arr1[k] = arr2[r]
    k--
    r--
  }
  return arr1
}
console.log(mergeSort([1,2,3,0,0,0], 3, [2,5,6],3))