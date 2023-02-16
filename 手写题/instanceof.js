/**
 * 在instanceof的底层原理是，利用instanceof左边实例的隐式原型和instanceof右边构造函数的显示原型进行循环比对。
 * 看看是否有哪一级能对上。有对的上的就返回true,一直顺着原型链找到头都没有比对成功的，返回false。
 * @param {*} el 
 * @param {*} type 
 */
const myInstance = (el, type) => {
  // 获取右边构造函数的显式原型
  const typeProto = type.prototype

  while(true) {
    // 如果隐式原型为null，说明已经查找到头了，依然没找到，说明类型不匹配，返回false
    if (el.__proto__ === null) return false
    // 如果数据的隐式原型和类型的显式原型重叠，则说明类型匹配，返回true
    if (el.__proto__ === typeProto) return true
    // 当前原型链层不为null也没有匹配，则去下一层匹配
    el = el.__proto__
  }
}

<img src="https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/b50408f1b3d649c1a8cde7a4104d5a06~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp?"></img>