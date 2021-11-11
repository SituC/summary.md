/**
 * 有序数组a从i = 0 开始向右滑动
 * 每次从i左边的a[0], a[i - 1]中随机取一个值与a[i]交换
 * 直到结束，生成一个无须数组
 */
function noSort(arr) {
  let result = [], random;
  while(arr.length > 0) {
    random = Math.floor(Math.random() * arr.length)
    result.push(arr[random])
    arr.splice(random, 1)
  }
  return result
}


let i = 0
while(i < 20) {
  i++
  const a = [1,2,3,4,5,6,7]
  const b = noSort(a)
  console.log(b)
}