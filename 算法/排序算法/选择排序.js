let arr = [3,1,4,5,2,3,666,12,434,43,35,45,2242]

function sort(arr) {
  let len = arr.length
  for (let i = 0; i < len - 1; i++) {
    let tempIndex = i
    for (let j = i + 1; j < len; j++) {
      if (arr[tempIndex] > arr[j]) {
        tempIndex = j
      }
    }
    if (tempIndex != i) {
      [arr[i], arr[tempIndex]] = [arr[tempIndex], arr[i]]
    }
  }
  return arr
}
console.log(sort(arr))