const sort = (arr) => {
  let len = arr.length
  if (len <= 1) {
    return arr
  }
  let mid = Math.floor(len / 2)
  let leftArr = sort(arr.slice(0, mid))
  let rightArr = sort(arr.slice(mid))
  arr = merge(leftArr, rightArr)
  return arr
}
const merge = (arr1, arr2) => {
  let i = 0, j = 0
  let len1 = arr1.length
  let len2 = arr2.length
  let res = []
  while(i < len1 && j < len2) {
    if (arr1[i] < arr2[j]) {
      res.push(arr1[i])
      i++
    } else {
      res.push(arr2[j])
      j++
    }
  }
  if (i < len1) {
    return res.concat(arr1.slice(i))
  } else {
    return res.concat(arr2.slice(j))
  }
}

console.log(sort([5,4,3,2,1]))

function review(arr) {
  let len = arr.length
  if (len < 2) return arr
  let mid = len >> 1
  let leftArr = arr.slice(0, mid)
  let rightArr = arr.slice(mid)
  let left = review(leftArr)
  let right = review(rightArr)
  return merge2(left, right)
}
function merge2(left, right) {
  let ans = []
  while (left.length > 0 && right.length > 0) {
    if (left[0] > right[0]) {
      ans.push(right.shift())
    } else {
      ans.push(left.shift())
    }
  }
  while(left.length) {
    ans.push(left.shift())
  }
  while(right.length) {
    ans.push(right.shift())
  }
  return ans
}

console.log(review([5,4,3,2,1]))
