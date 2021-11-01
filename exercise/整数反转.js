/**
 * 题目：给你一个 32 位的有符号整数 x ，返回将 x 中的数字部分反转后的结果。

 * 如果反转后整数超过 32 位的有符号整数的范围 [−231,  231 − 1] ，就返回 0。

 * 假设环境不允许存储 64 位整数（有符号或无符号）。

 */
var reverse = function(x) {
  let res = 0;
  while(x){
      res = res * 10 + x % 10;
      if(res > Math.pow(2, 31) - 1 || res < Math.pow(-2, 31)) return 0;
      x = ~~(x / 10);
  }
  return res;
};

// 暴力解法
var reverse = function(x) {
  let flg = true
  x > 0 ? flg = true : flg = false
  let str = Math.abs(x).toString().split('').reverse()
  str = flg ? str.join('') : ('-' + str.join(''))
  str = Number(str)
  if (str > Math.pow(2, 31) || str < Math.pow(-2, 31)) return 0
  return str
 };