```js
export interface Ref<T = any> {
  // value值
  value: T
  // 此项为了打包过后在.d.ts文件中使用，但是又不想ide显示这项，所以在这里用的symlol属性
  [RefSymbol]: true
  /**
   * 内部属性
   */
  _shallow?: boolean
}

```