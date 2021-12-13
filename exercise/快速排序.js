const sort = (arr, left = 0, right = arr.length - 1) => {
  if (arr.length > 1) {
    let index = getIndex(arr, left, right)
    if (left < index - 1) {
      sort(arr, left, index - 1)
    }
    if (right > index) {
      sort(arr, index, right)
    }
  }
  return arr
}

const getIndex = (arr, left, right) => {
  let pivod = Math.floor(left + (right - left ) / 2)
  let pivodValue = arr[pivod]
  let i = left
  let j = right
  while(i <= j) {
    while(arr[i] < pivodValue) {
      i++
    }
    while(arr[j] > pivodValue) {
      j--
    }
    if (i <= j) {
      swap(arr, i ,j)
      i++
      j--
    }
  }
  return i
}
const swap = (arr, i, j) => {
  [arr[i], arr[j]] = [arr[j], arr[i]]
}

console.log(sort([5,4,3,2,1]))