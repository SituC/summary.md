一直以来写代码的时候的常用习惯就是吧所有的js文件直接加载在文档的head标签里面，在写js文件的时候有时候获取一些文件对象的时候为空对象，这是由于文档结构还没有加载完，但是js文件已经加载完。也就是说虽然写了js语句来获取对象，但是由于dom结构还没有加载完成，因此获取到的是空对象，进一步测试发现在firebug的控制台下把赋值语句执行之后可以获得对象，同理是因为在文档已经得到显示之后文档结构已经处于加载完成的状态，所以可以直接获取到对应的文档对象。

- 解决方法用两种：`defer`和`async`。

`defer="defer"`:该属性用来通知浏览器，这段脚本代码将不会产生任何文档内容。例如 JavaScript代码中的document.write()方法将不会骑作用，浏览器遇到这样的代码将会忽略，并继续执行后面的代码。属性只能是 defer，与属性名相同。在HTML语法格式下，也允许不定义属性值，仅仅使用属性名。
async="true/false":该属性为html5中新增的属性，它的作用是能够异步地下载和执行脚本，不因为加载脚本而阻塞页面的加载。一旦下载完毕就会立刻执行。
script中的defer属性默认情况下是false的，因此在使用时需要显式调用这一属性。
defer既可用于载入js文件，也可用于行内脚本。
加上 defer 等于在页面完全在入后再执行，相当于 window.onload ，但应用上比 window.onload 更灵活！实际上 defer 更接近于 DomContentLoad。
事实上脚本执行于onload事件之前，即文档载入后即执行，不用等于包括图片在内的资源下载完毕。

`async`和defer一样，都不会阻塞其他资源下载，所以不会影响页面的加载，但在async的情况下，js文档一旦下载完毕就会立刻执行，所以很有可能不是按照原本的顺序来执行，如果js有依赖性，就要注意了。

## defer和async的比较

### 相同点：    

- 加载文件时不阻塞页面渲染；
- 对于inline的script无效；
- 使用这两个属性的脚本中不能调用document.write方法；
- 有脚本的onload的事件回调；
- 允许不定义属性值，仅仅使用属性名；

### 不同点：

- html的版本html4.0中定义了defer；html5.0中定义了async；这将造成由于浏览器版本的不同而对其支持的程度不同；
- 执行时刻：每一个async属性的脚本都在它下载结束之后立刻执行，同时会在window的load事件之前执行。所以就有可能出现脚本执行顺序被打乱 的情况；每一个defer属性的脚本都是在页面解析完毕之后，按照原本的顺序执行，同时会在document的DOMContentLoaded之前执 行。

### 这两个属性会有三种可能的组合：

- 如果async为true，那么脚本在下载完成后异步执行。
- 如果async为false，defer为true，那么脚本会在页面解析完毕之后执行。
- 如果async和defer都为false，那么脚本会在页面解析中，停止页面解析，立刻下载并且执行

```html
<script type="text/javascript" src="js/index.js" defer></script>直接放在head标签中
<div id="first_menu">
    <ul>
        <li class="individual_info">
            <div class="menu_content">
                <i class="fa fa-user"></i>
                <p>个人信息</p>
            </div>
        </li>
        <li class="prizes_amount">
            <div class="menu_content">
                <i class="fa fa-pencil-square-o"></i>
                <p>获奖统计</p>
            </div>
        </li>
        <li class="attendence_management">
            <div class="menu_content">
                <i class="fa fa-calendar"></i>
                <p>考勤管理</p>
            </div>
        </li>
        <li class="expand_tables">
            <div class="menu_content">
                <i class="fa fa-file-excel-o"></i>
                <p>拓展表项</p>
            </div>
        </li>
    </ul>
</div>
js代码：var li_list=$("#first_menu ul li");
```
没有添加defer之前获取的li_list为空对象，添加defer属性之后可以正常获取对象
将async属性设置为true之后同样也可以获取到对象