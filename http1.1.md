# 特性

- 连接可以复用：`connection: keep-alive`。支持长连接，在一个TCP连接上可以传送多个HTTP请求和响应，减少了建立和关闭连接的消耗和延迟，在http1.1中默认开启`conncetion: keep-alive`
- 增加了管道化技术: `HTTP pipelinling`：允许在一个应答被完全发送完成之前就发送第二个请求，以降低通信延迟。复用同一个TCP连接期间，即便是通过管道同时发送了多个请求，服务端也是按请求的顺序依次给出响应的。而客户端在未收到之前所发出的所有请求的响应之前，将会阻塞后面的请求（排队等待），这成为`队头堵塞`

- 支持响应分块，支持编码传输
- 引入额外的缓存控制机制：在 HTTP1.0 中主要使用 header 里的 `If-Modified-Since`,`Expires` 等来做为缓存判断的标准，HTTP1.1 则引入了更多的缓存控制策略例如 `Entity tag`, `If-None-Match`，`Cache-Control` 等更多可供选择的缓存头来控制缓存策略。商业转载请联系作者获得授权，非商业转载请注明出处。
- `HOST`头：新增的一个请求头，主要用来实现虚拟主机技术