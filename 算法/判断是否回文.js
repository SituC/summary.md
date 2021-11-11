// 字符串
function isPalindrome(str) {
  let len = str.length
  for (let i = 0; i < len / 2; i++) {
    if (str[i] !== str[len - i - 1]) {
      return false
    }
  }
  return flg
}

// 数组
function isPalindrome(arr, start = 0, end = arr.length - 1) {
  while(start < end) {
    if (arr[start] !== arr[end]) {
      return false
    }
    start++
    end--
  }
  return true
}