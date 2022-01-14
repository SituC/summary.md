"use strict";

var arr = [3, 1, 4, 5, 2, 3, 666, 12, 434, 43, 35, 45, 2242];

function sort(arr) {
  var len = arr.length;
  var temp;

  for (var i = 1; i < len; i++) {
    var j = i;
    temp = arr[i]; // 将i前面所有比arr[i]大的向后移一位

    while (j > 0 && arr[j - 1] > temp) {
      arr[j] = arr[j - 1];
      j--;
    } // 插入temp


    arr[j] = temp;
  }

  return arr;
}

console.log(sort(arr));