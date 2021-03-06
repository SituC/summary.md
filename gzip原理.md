# 压缩原理

## 压缩核心之Deflate

gzip的核心是 `deflate`，deflate是一个同时使用 `LZ77` 与 `Huffman Coding`的算法

### LZ77

LZ77的核心思路是如果一个串中有两个重复的串，**那么只需要知道第一个串的内容和后面串相对于第一个串起位置的距离 + 串的长度**

比如：ABCDEFGABCDEFH → ABCDEFG(7, 6)H。7指的是往前第 7 个数开始，6指的是重复串的长度，ABCDEFG(7, 6)H完全可以表示前面的串，并且是没有二义性的。

LZ77用 `滑动窗口` 实现的算法。

gzip 并不是万能的，它的原理是在一个文本文件中找一些重复出现的字符串、临时替换它们，从而使整个文件变小，所以对于图片等会处理不了。

核心算法是哈夫曼算法和LZ77

## 为什么在本地进行gzip
服务器压缩也需要时间开销和 CPU 开销，所以有时候可以用 Webpack 来进行 gzip 压缩，从而为服务器分压。

服务器查找到有与源文件同名的.gz文件就会直接读取，不会主动压缩，降低cpu负载，优化了服务器性能

## 是否所有文件都需要开启 gzip
如果压缩文件太小，那不使用；但是如果具有一定规模的项目文件，比如10K以上，可以开启 gzip。

媒体文件无需开启: 图片、音乐、视频大多数已经压缩过了。一般只需要压缩html, css, javascript