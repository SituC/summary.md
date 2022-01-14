1. DNS解析
域名从右向左分为顶级域名、二级域名、三级域名依次类推

输入url过后，先查找浏览器是否有dns缓存，没找到再查找host文件是否有记录。没找到再去本地的dns服务器查找是否有缓存。然后再去计算机上配置的dns服务器上是否有缓存，还是没有就去查找根dns服务器，全球13台，固定ip地址，然后判断.com域名是哪个服务器管理。找到过后就返回ip。

浏览器 -> 系统 -> 路由器 -> ISP（互联网服务提供商，也就是域名系统）

前端dns优化
```html
<meta http-equiv="x-dns-prefetch-control" content="on" />
<link rel="dns-prefetch" href="http://bdimg.share.baidu.com" />
```

拿到ip过后就进行TPC解析

首先建立三次握手
