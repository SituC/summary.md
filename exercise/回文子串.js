/**
 * 题目
 * 给你一个字符串 s，找到 s 中最长的回文子串。
 * 输入：s = "babad"
 * 输出："bab"
 * 解释："aba" 同样是符合题意的答案。
 */


/**
 * @param {string} s
 * @return {string}
 */
// 中心扩散法
var longestPalindrome = function(s) {
  if (s.length < 2) return s
  let res = ''
  for (let i = 0; i < s.length; i++) {
    helper(i, i)
    helper(i, i + 1)
  }
  var helper = function(m, n) {
    while(m >= 0 && n <= s.length - 1 && s[m] === s[n]) {
      m--
      n++
    }
    // 因为最后一次循环完毕后n--了m++了，所以n，m应该取n-1 m+1的区间，长度为n - m - 1
    if (n - m - 1 > res.length) {
      res = s.slice(m + 1, n)
    }
  }
  return res
}
// 动态规划
// 状态dp[i][j]以下标i开头j结尾的字串是否是回文串
var longestPalindrome = function(s) {
  let res = ''
  let len = s.length
  let dp = Array.from(Array(len), () => Array(len).fill(false))
  // 下半区右下角开始
  for (let i = len - 1; i >= 0 ; i--) {
    for (let j = i; j < len; j++) {
      // 在两个端点相等的情况下，如果长度为1则回文，如果dp[i + 1][j - 1]为true（之前计算过）也为回文
      dp[i][j] = s[i] === s[j] && (j - i < 2 || dp[i + 1][j - 1])
      if (dp[i][j] && j - i + 1 > res.length) {
        res = s.substring(i, j + 1)
      }
    }
  }
  return res
}