function fn(key, index) {
  if(index <= key) return 1
  const arrKey = new Array(key).fill(1);
  let i = key;
  while(i <= index) {
    arrKey[i] = arrKey[i-1]  + arrKey[i - 2];
    i++;
  }
  return arrKey[index]
}