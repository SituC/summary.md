function bigNumberSum(a, b) {
  a = '' + a
  b = '' + b
  const len = Math.max(a.length, b.length)
  a = a.padStart(len, '0')
  b = b.padStart(len, '0')

  let carried = 0
  const res = []

  for (let i = a.length - 1; i > -1; i--){
    const sum = carried + +a[i] + +b[i]
    sum > 9 ? carried = 1 : carried = 0
    console.log(sum)
    res[i] = sum % 10
  }
  if (carried === 1) {
    res.unshift(1)
  }
  return res.join('')
}

console.log(bigNumberSum(123456789, 9876))