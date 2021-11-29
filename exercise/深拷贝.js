const deepClone = (obj, hash = new WeakMap()) => {
  if (obj == null) return obj
  if (obj instanceof Date) return new Date(obj)
  if (obj instanceof RegExp) return new RegExp(obj)
  if (obj !== 'object') return obj
  if (hash.get(obj)) return hash.get(obj)
  const childObj = new obj.constructor()
  hash.set(obj, childObj)
  for (let key in obj) {
    if (obj.hasOwnProperty(key)) {
      childObj[key] = deepClone(obj[key], hash)
    }
  }
  return childObj
}