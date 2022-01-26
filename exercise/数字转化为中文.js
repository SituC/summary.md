function numToChinese(num) {
  const numStr = String(num);
  const numMapper = [
    "零",
    "一",
    "二",
    "三",
    "四",
    "五",
    "六",
    "七",
    "八",
    "九"
  ];

  const unitMapper = [, , "十", "百", "千", "万"];

  let res = "";

  for (let i = 0; i < numStr.length; i++) {
    const chNum = 
      numStr[i] === "0" && res[res.length - 1] === "零"
        ? ""
        : numMapper[numStr[i]];
    console.log(numStr.length, i, unitMapper[numStr.length - i])
    const unit = numStr[i] === "0" ? "" : unitMapper[numStr.length - i] || "";
    // console.log(res, chNum, unit)
    res = res + chNum + unit;
  }

  return res[res.length - 1] === "零" ? res.slice(0, -1) : res;
}

console.log(numToChinese(123))