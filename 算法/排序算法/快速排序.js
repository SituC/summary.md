let arr = [3, 1, 4, 5, 2, 3, 666, 12, 434, 43, 35, 45, 2242]

function quickSort (arr, left = 0 , right = arr.length - 1) {
  if (arr.length > 1) {
    // lineIndex表示下一次划分左右子数组的索引位
    const lineIndex = partition(arr, left, right)
    if (left < lineIndex - 1) {
      // 左子数组以lineIndex - 1为边界
      quickSort(arr, left, lineIndex - 1)
    }
    // 如果右边子数组长度不小于1，则递归快排这个子数组
    if (lineIndex < right) {
      quickSort(arr, lineIndex, right)
    }
  }
  return arr
}

// 以基准值为轴心，划分左右数组的过程
function partition (arr, left, right) {
  // 基准值默认取中间位置的元素
  let pivotValue = arr[Math.floor(left + (right - left) / 2)]
  // 初始化左右指针
  let i = left
  let j = right
  // 当左右指针不越界时，循环执行以下逻辑
  while(i <= j) {
    while(arr[i] < pivotValue) {
      i++
    }
    while(arr[j] > pivotValue) {
      j--
    }
    // 若i<=j，则意味着基准值左边存在较大元素或右边存在较小元素，交换两个元素确保左右两侧有序
    // 上面两个while是在进行比较值，如果到了这一步说明是存在需要进行位置交换的异常情况
    if (i <= j) {
      swap(arr, i, j)
      i++
      j--
    }
  }
  return i
}

function swap (arr, i, j) { [arr[i], arr[j]] = [arr[j], arr[i]]
}
console.log(quickSort(arr))

var quickSort = function (arr, left = 0, right = arr.length - 1) { 　　
  if (arr.length > 1) {
    let lineIndex = getLineIndex(arr, left, right)
    if (left < lineIndex - 1) {
      arr = quickSort(arr, left, lineIndex - 1)
    }
    if (right > lineIndex) {
      arr = quickSort(arr, lineIndex - 1, right)
    }
  }
  return arr
}

function getLineIndex(arr, leftIndex, rightIndex) {
  let pivotValue = arr[Math.floor(left + (right - left) / 2)]
  let l = leftIndex
  let r = rightIndex
  while(l <= r) {
    while(arr[l] < pivotValue) {
      l++
    }
    while(arr[r] > pivotValue) {
      r--
    }
    if (l <= r) {
      swep(arr, l, r)
      l++
      r--
    }
  }
  return l
}

function swer(arr, l, r) {
  [arr[l], arr[r]] = [arr[r], arr[l]]
}
