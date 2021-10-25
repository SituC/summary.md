```js
import { toArray } from '../util/index'

export function initUse (Vue: GlobalAPI) {
  Vue.use = function (plugin: Function | Object) {
    const installedPlugins = (this._installedPlugins || (this._installedPlugins = []))
    if (installedPlugins.indexOf(plugin) > -1) { // 判断是否已经注册了当前组件，组件全局只需要注册一次
      // 如果已经存在了插件对象，则直接返回 Vue对象
      return this
    }

    const args = toArray(arguments, 1)
    // 将Vue对象拼接到数组头部
    args.unshift(this)
    if (typeof plugin.install === 'function') {
      // 如果组件是对象，且提供了install方法，调用install方法将参数数组传入，改变this指针为该组件
      plugin.install.apply(plugin, args)
    } else if (typeof plugin === 'function') {
      plugin.apply(null, args)
    }
    installedPlugins.push(plugin)
    return this
  }
}

```
toArray源码
```js
export function toArray (list: any, start?: number): Array<any> {
  start = start || 0
  let i = list.length - start
  //将存放参数的数组转为数组，并除去第一个参数（该组件）
  const ret: Array<any> = new Array(i)
  //循环拿出数组
  while (i--) {
    ret[i] = list[i + start]
  }
  return ret
}
```
`use`的内部是用一个数组维护所有插件，并且插件具备唯一原则，也就是插件全局只会注册一次。