# demoblock
## 引入背景
早期进行组件开发的时候，demo展示部分需要用` ``` `包裹展示的代码块，另外组件的显示也需要同样的代码，所以同样的代码写了两遍，非常的不“银杏”。比如下面这样
```html
<!-- index.md -->

  <!-- 以下是显示组件部分 -->
  <d-icon name="emoji"><d-icon>
  <d-icon name="emoji" color="#3dcca6"><d-icon>

  <!-- 以下是暴露到文档的代码块 -->
  <!-- 需要再次重复写同样的代码 -->
  ```html
  <d-icon name="emoji"><d-icon>
  <d-icon name="emoji" color="#3dcca6"><d-icon>
　```

```

Kagol带头讨论了这个问题。大家也给出了自己的想法。

边讨论的时候我就开始看网上有没有现成的方案了。
毕竟
<p>
  <img src="./static/css.md/123.png">
</p>

但是`vitepress`和`vue3`当时解决方案还不太多，所以也不抱太多希望。

不过最终很幸运的发现了两款支持vitepress的demo展示插件`vitepress-theme-demoblock`和`vitepress-for-component`。但最后调研发现`vitepress-for-component`是 fork 自 `vitepress`的脚手架，并不单单是一个插件了，不好集成到devui中，最后就确定了`vitepress-theme-demoblock`。

● 引入这个功能的背景
● 技术方案的选型
● 遇到的问题（与开源作者的沟通）
● demoblock的引入和效果






