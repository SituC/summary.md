var checkInclusion = function (s1, s2) {
  // 统计所需字符及其个数
  const need = new Map()
  for (let i = 0; i < s1.length; i++) {
    need.set(s1[i], need.has(s1[i]) ? need.get(s1[i]) + 1 : 1)
  }
  // 定义滑动窗口
  let left = 0, right = 0
  // 有效的字符的个数
  let valid = 0
  // 统计当前窗口中的字符及其个数
  const window = new Map()
  // 当窗口滑动到s2的末尾时候结束循环
  while (right < s2.length) {
    // 进入窗口的字符
    const c = s2[right]
    // 扩大窗口
    right++
    // 如果进入的字符是需要的字符
    if (need.has(c)) {
      // 修改窗口字符记录
      window.set(c, window.has(c) ? window.get(c) + 1 : 1)
      // 进入的字符已经达标
      if (window.get(c) === need.get(c)) {
        // 有效字符数自增
        valid++
      }
    }
    // 当窗口子串长度大于等于s1的长度的时候开始收缩窗口（排列长度一致）
    while (right - left >= s1.length) {
      // 离开窗口的字符
      const d = s2[left]
      // 如果有效字符数和所需字符数一致
      if (valid === need.size) {
        // 找到符合条件的子串
        return true
      }
      // 收缩窗口
      left++
      // 如果离开窗口的字符是需要的字符
      if (need.has(d)) {
        // 如果离开的字符是数量达标的字符
        if (window.get(d) === need.get(d)) {
          // 有效字符数自减
          valid--
        }
        // 修改窗口记录
        window.set(d, window.get(d) - 1)
      }
    }
  }
  // 没找到符合条件的子串
  return false
}
