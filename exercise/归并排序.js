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