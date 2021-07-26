# session的实现
### session的组成
session一般由三个组件配合完成，分别是`Manager` `Provider` `Session`三个类（接口）
<p>
<img src="https://labuladong.gitee.io/algo/images/session/4.jpg" />
</p>

1. 浏览器通过`HTTP协议`向服务器请求路径`/content`的网页资源，对应路径上`Handler函数`接受请求，解析`HTTP header`中的`cookie`，得到其中存储的`sessionID`，然后把这个ID发给`Manager`

2. `Manager` 充当一个session管理器的角色，主要存储一些配置信息，比如`session的存活时间`，`cookie的名字`等等。而所有的session存在`Manager`内部的一个`Provider`中。所以`Manager`会把`sid`传递给`Provider`，让它去找这个ID对应的具体是哪个session。

3. `Provider`就是一个容器，最常见的应该就是一个`散列表（hash表）`，将每个`sid`和对应的`session`一一映射起来。收到`Manager`传递的`sid`之后，它就找到`sid`对应的session结构，也就是`Session`结构，然后返回它

4. `Session`中存储着用户的具体信息，由`Handler`函数中的逻辑拿出这些信息，生成该用户的HTML网页，返回给客户端。

> 为什么不直接在Handler函数中搞一个哈希表，然后存储`sid`和`Session`结构的映射呢？

**`这就是设计层面的技巧了`**，下面就来说说，为什么分成`Manager`、`Provider`、`Session`。
先从最底层的`Session`说，既然session就是键值对，为什么不直接用哈希表，而是要抽象出这么一个数据结构呢？
1. 因为`Session`结构可能不止存储了一个哈希表，还可以存储一些辅助数据，比如`sid`，`访问次数`，`过期时间`或者`最后一次的访问时间`，这样便于实现`LRU`、`LFU`这样的算法。

>LRU，即最近最少使用，是一种常用的页面置换算法，选择最近最久未使用的页面予以淘汰。该算法赋予每个页面一个访问字段，用来记录一个页面自上次被访问以来所经历的时间 t，当须淘汰一个页面时，选择现有页面中其 t 值最大的，即最近最少使用的页面予以淘汰。

>LFU，即最不经常使用页置换算法，要求在页置换时置换引用计数最小的页，因为经常使用的页应该有一个较大的引用次数。但是有些页在开始时使用次数很多，但以后就不再使用，这类页将会长时间留在内存中，因此可以将引用计数寄存器定时右移一位，形成指数衰减的平均使用次数。

2. 因为session可以有`不同的存储方式`。如果用编程语言内置的哈希表，那么session数据就是存储在内存中，如果数据量大，很容易造成程序包崩溃，而且一旦程序结束，所有session数据都会丢失。所以可以有很多种session的存储方式，比如存入缓存数据库`Redis`、`Mysql`等等

因此，`Session`结构提供一层抽象，屏蔽不同存储方式的差异，只提供一组通用接口操作键值对：
```js
type Session interface {
    // 设置键值对
    Set(key, val interface{})
    // 获取 key 对应的值
    Get(key interface{}) interface{}
    // 删除键 key
	Delete(key interface{})
}
```
再说`Provider`为啥要抽象出来。上面那个图的`Provider`就是一个散列表，保存`sid`到`Session`的映射，但是实际中肯定会更加复杂。我们需要时不时删除一些session，除了设置存活时间之外，还可以采用一些其他策略，比如`LRU缓存淘汰算法`，这样就需要`Provider`内部使用`哈希链表`这种数据结构来存储session。

因此，`Provider`作为一个容器，就是要`屏蔽算法细节`，以合理的`数据结构`和`算法`组织`sid`和`Session`的映射关系，只需要实现下面这几个方法实现对session的增删改查：
```js
type Provider interface {
    // 新增并返回一个 session
    SessionCreate(sid string) (Session, error)
    // 删除一个 session
    SessionDestroy(sid string)
    // 查找一个 session
    SessionRead(sid string) (Session, error)
    // 修改一个session
    SessionUpdate(sid string)
    // 通过类似 LRU 的算法回收过期的 session
	  SessionGC(maxLifeTime int64)
}
```
最后说`Manager`，大部分具体工作都委托给`Session`和`Provider`承担了，`Manager`主要就是一个参数集合，比如`session存活时间`，`清理过期session的策略`，以及`session的可用存储方式`。`Manager`屏蔽了操作的具体细节，我们可以通过`Manager`灵活地配置session机制。

综上，session 机制分成几部分的最主要原因就是 **`解耦`，实现`定制化`**
# 参考：
[一文看懂 session 和 cookie](https://labuladong.gitee.io/algo/6/51/)