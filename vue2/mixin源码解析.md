## 入口

```js
// vue/src/core/global-api/mixin.js
export function initMixin (Vue: GlobalAPI) {
  Vue.mixin = function (mixin: Object) {
    this.options = mergeOptions(this.options, mixin)
    return this
  }
}
```

通过`mergeOptions`方法将全局基础`options`和传入的mixin进行合并

全局基础的options有
```js
// vue/src/core/global-api/index.js
Vue.options = Object.create(null)
ASSET_TYPES.forEach(type => {
  Vue.options[type + 's'] = Object.create(null)
})
```
其中ASSET_TYPES是`['component', 'directive', 'filter']`,也就是全局的基础options是`'component', 'directive', 'filter'`

`mergeOptions`的作用是根据`不同options属性类型`，进行`合并、替换、队列、叠加属性`

```js
// vue/src/core/util/options.js
export function mergeOptions (
  parent: Object,
  child: Object,
  vm?: Component
): Object {

if (child.mixins) { // 判断有没有mixin 也就是mixin里面挂mixin的情况 有的话递归进行合并
    for (let i = 0, l = child.mixins.length; i < l; i++) {
    parent = mergeOptions(parent, child.mixins[i], vm)
    }
}

  const options = {} 
  let key
  for (key in parent) {
    mergeField(key) // 先遍历parent的key 调对应的strats[XXX]方法进行合并
  }
  for (key in child) {
    if (!hasOwn(parent, key)) { // 如果parent已经处理过某个key 就不处理了
      mergeField(key) // 处理child中的key 也就parent中没有处理过的key
    }
  }
  function mergeField (key) {
    const strat = strats[key] || defaultStrat
    options[key] = strat(parent[key], child[key], vm, key) // 根据不同类型的options调用strats中不同的方法进行合并
  }
  return options
}
```

- 先递归判断子项中是否还有mixin，有则递归添加合并
- 先合并parent中的key，保存在options中
- 再合并child中的key，如果parent已经合并过则跳过（因为递归时，parent也已经合并了child中的key了）
- 最后调用`strat`根据不同类型属性进行不同的合并

### 替换型合并

`props、methods、inject、computed`属于替换式

```js
strats.props =
strats.methods =
strats.inject =
strats.computed = function (
  parentVal: ?Object,
  childVal: ?Object,
  vm?: Component,
  key: string
): ?Object {
  if (!parentVal) return childVal // 如果parentVal没有值，直接返回childVal
  const ret = Object.create(null) // 创建一个第三方对象 ret
  extend(ret, parentVal) // extend方法实际是把parentVal的属性复制到ret中
  if (childVal) extend(ret, childVal) // 把childVal的属性复制到ret中
  return ret
}
strats.provide = mergeDataOrFn
```
props、methods、inject、computed的合并策略都是将新的同名参数替代旧的参数

### 合并型合并

data属于合并型

源码简写
```js
strats.data = function(parentVal, childVal, vm) {    
    return mergeDataOrFn(
        parentVal, childVal, vm
    )
};

function mergeDataOrFn(parentVal, childVal, vm) {    
    return function mergedInstanceDataFn() {        
        var childData = childVal.call(vm, vm) // 执行data挂的函数得到对象
        var parentData = parentVal.call(vm, vm)        
        if (childData) {            
            return mergeData(childData, parentData) // 将2个对象进行合并                                 
        } else {            
            return parentData // 如果没有childData 直接返回parentData
        }
    }
}

function mergeData(to, from) {    
    if (!from) return to    
    var key, toVal, fromVal;    
    var keys = Object.keys(from);   
    for (var i = 0; i < keys.length; i++) {
        key = keys[i];
        toVal = to[key];
        fromVal = from[key];    
        // 如果不存在这个属性，就重新设置
        if (!to.hasOwnProperty(key)) {
            set(to, key, fromVal);
        }      
        // 存在相同属性，合并对象
        else if (typeof toVal =="object" && typeof fromVal =="object") {
            mergeData(toVal, fromVal);
        }
    }    
    return to
}

```
遍历了要合并的 data 的所有属性，然后根据不同情况进行合并：
- 当目标 data 对象不包含当前属性时，调用 set 方法进行合并，set方法主要是进行属性赋值重新合并并进行依赖收集。
- 当目标 data 对象包含当前属性并且当前值为纯对象时，递归合并当前对象值，这样做是为了防止对象存在新增属性。

### 队列型
全部生命周期函数和watch都是队列型合并策略
```js
function mergeHook (
  parentVal: ?Array<Function>,
  childVal: ?Function | ?Array<Function>
): ?Array<Function> {
  return childVal
    ? parentVal
      ? parentVal.concat(childVal)
      : Array.isArray(childVal)
        ? childVal
        : [childVal]
    : parentVal
}

LIFECYCLE_HOOKS.forEach(hook => {
  strats[hook] = mergeHook
})
```
Vue 实例的生命周期钩子被合并为一个数组，然后正序遍历一次执行

### 叠加型

component、directives、filters属于叠加型的策略

```js
strats.components=
strats.directives=

strats.filters = function mergeAssets(
    parentVal, childVal, vm, key
) {    
    var res = Object.create(parentVal || null);    
    if (childVal) { 
        for (var key in childVal) {
            res[key] = childVal[key];
        }   
    } 
    return res
}
```
通过原型链进行层层的叠加

# 总结
- 在我们调用Vue.mixin的时候会通过mergeOptions方法将全局基础options(component', 'directive', 'filter)进行合并
- 在mergeOptions内部优先进行mixins的递归合并，然后先父再子调用mergeField进行合并，不同的类型走不同的合并策略
- 替换型策略有props、methods、inject、computed, 就是将新的同名参数替代旧的参数
- 合并型策略是data, 通过set方法进行合并和重新赋值
- 队列型策略有生命周期函数和watch，原理是将函数存入一个数组，然后正序遍历依次执行
- 叠加型有component、directives、filters，将回调通过原理链联系在一起