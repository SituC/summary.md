# route对象
route是一个跳转的路由对象，每一个路由都会有一个route对象，是一个局部的对象，标识当前的路由信息，包含当前URL解析得到的信息，包含当前的路径、参数、query对象等。


<img src="https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/37f46f0feea040df8ffe668f5a84e95f~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.image">

- $route.path： 字符串，对应当前路由的路径，总是解析为绝对路径，如/foo/bar。
- $route.params： 一个 key/value 对象，包含了 动态片段 和 全匹配片段，如果没有路由参数，就是一个空对象。
- $route.query： 一个 key/value 对象，表示 URL 查询参数。例如，对于路径 /foo?user=1，则有$route.query.user == 1，如果没有查询参数，则是个空对象。
- $route.hash： 当前路由的hash值 (不带#) ，如果没有 hash 值，则为空字符串。锚点*
- $route.fullPath： 完成解析后的 URL，包含查询参数和hash的完整路径。
- $route.matched： 数组，包含当前匹配的路径中所包含的所有片段所对应的配置参数对象。
- $route.name： 当前路径名字
- $route.meta： 路由元信息


# router对象
router对象是全局路由的实例，是router构造方法的实例。router是VueRouter的一个对象，通过Vue.use(VueRouter)和Vue构造函数得到一个router的实例对象，包含了所有的路由还有许多关键的对象和属性。

<img src="https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/81dc541b569e4d84873d96997be3f12a~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.image">