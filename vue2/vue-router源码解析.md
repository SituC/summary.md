### hash 模式

使用`onhashchange`监听路由的改变，但是需要路由必须加上`#`，也就是监听`#后面的URL部分，包括#号`。注意 history.pushState()绝对不会触发hashchange事件。

### history 模式

- pushState()：需要三个参数：一个状态对象，一个标题（目前被忽略）和一个url
  - state: 状态对象state是一个js对象，popstate事件触发时，该对象会传入回调函数
  - title: 目前所有浏览器忽略
  - url: 新的url记录

- replaceState(): history.replaceState()的使用与history.pushState()非常相似，区别在于replaceState()是修改了当前的历史记录项而不是新建一个。

- onpopstate: 调用history.pushState()或者history.replaceState()不会触发popstate事件. popstate事件只会在浏览器某些行为下触发, 比如点击后退、前进按钮(或者在JavaScript中调用history.back()、history.forward()、history.go()方法)。


# 源码解析
## install

install文件中，劫持了`$route、$router`的getter，当访问时，返回实例上的 `route和router`

并且在Vue的实例上初始化了一些私有属性

- _routerRoot, 指向了Vue的实例
- _router, 指向了VueRouter的实例
在Vue的prototype上初始化了一些getter

- $router, 当前Router的实例
- $route, 当前Router的信息

并且在全局混入了mixin, 已经全局注册了`RouterView`, `RouterLink`组件.
