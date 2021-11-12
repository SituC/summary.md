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
    // partition中对于左右指针的操作最后会变成左指针 - 右指针 = 1，也就是以左指针为界限，左边的值都不大于它，右边的值都不小于它（包括右指针的值）
    // 比如 [1,2,3,4]  [5,6]，下面的lineIndex就代表5的下标，5是包括在右子数组里面的
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
    // 左边值小于基准值，右移左指针
    while(arr[i] < pivotValue) {
      i++
    }
    // 右边值大于基准值，左移右指针
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
// console.log(quickSort(arr))


const quickSort2 = (arr, left = 0, right = arr.length - 1) => {
  if (arr.length > 1) {
    const midIndex = findMidIndex(arr, left, right)
    if (midIndex < right) {
      quickSort2(arr, midIndex, right)
    }
    if (midIndex - 1 > left) {
      quickSort2(arr, left, midIndex - 1)
    }
  }
  return arr
}

const findMidIndex = (arr, left, right) => {
  const pivot = arr[Math.floor(left + (right - left) / 2)]
  let l = left, r = right
  while(l <= r) {
    while (arr[l] < pivot) {
      l++
    }
    while (arr[r] > pivot) {
      r--
    }
    if (l <= r) {
      [arr[l], arr[r]] = [arr[r], arr[l]]
      l++
      r--
    }
  }
  return l
}

console.log(quickSort2(arr))
