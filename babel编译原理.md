### Babel
Babel 是一个工具链，主要用于在旧的浏览器或环境中将 ECMAScript 2015+ 代码转换为向后兼容版本的 JavaScript 代码：

Polyfill 实现目标环境中缺少的功能 (通过 @babel/polyfill)源代码转换 (codemods)

打包工具将程序以`字符串形式`传递给babel，babel会返回一段新的代码字符串（以及sourcemap）。本质就是一个`编译器`，输入语言是es6+，编译目标语言是es5


三个工作阶段

`1. 解析parse `: 将代码字符串解析成抽象语法树AST

`2. 变换transform `：对AST进行增删改

`3. 在建generate `: 根据变换后的抽象语法树再生成代码字符串并生成sourcemap

<p>
<img src="https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/63717d7589cf415680373ede5f4f7089~tplv-k3u1fbpfcp-watermark.image"/>
</p>

编译例子
```javascript
if (1 > 0) {
    alert('hi');
}
```
经过`第一步`得到如下的对象:
```json
{
  "type": "Program",                          // 程序根节点
  "body": [                                   // 一个数组包含所有程序的顶层语句
    {
      "type": "IfStatement",                  // 一个if语句节点
      "test": {                               // if语句的判断条件
        "type": "BinaryExpression",           // 一个双元运算表达式节点
        "operator": ">",                      // 运算表达式的运算符
        "left": {                             // 运算符左侧值
          "type": "Literal",                  // 一个常量表达式
          "value": 1                          // 常量表达式的常量值
        },
        "right": {                            // 运算符右侧值
          "type": "Literal",
          "value": 0
        }
      },
      "consequent": {                         // if语句条件满足时的执行内容
        "type": "BlockStatement",             // 用{}包围的代码块
        "body": [                             // 代码块内的语句数组
          {
            "type": "ExpressionStatement",    // 一个表达式语句节点
            "expression": {
              "type": "CallExpression",       // 一个函数调用表达式节点
              "callee": {                     // 被调用者
                "type": "Identifier",         // 一个标识符表达式节点
                "name": "alert"
              },
              "arguments": [                  // 调用参数
                {
                  "type": "Literal",
                  "value": "hi"
                }
              ]
            }
          }
        ]
      },
      "alternative": null                     // if语句条件未满足时的执行内容
    }
  ]
}
```
图像表示上面逻辑：
<p>
<img src="https://pic4.zhimg.com/80/v2-d8f6058c57101f03d54734783f14d3fb_1440w.png" />
</p>

第1步转换的过程中可以`验证语法的正确性`，同时由字符串变为对象结构后更有利于精准地分析以及进行代码结构调整。

第2步原理就是`遍历`这个对象所描述的抽象语法树，遇到哪里需要做一下改变，就`直接在对象上进行操作`，比如我把IfStatement给改成WhileStatement就达到了把条件判断改成循环的效果。

第3步也简单，递归遍历这颗语法树，然后生成相应的代码，大概的实现逻辑如下：
```javascript
const types = {
  Program (node) {
    return node.body.map(child => generate(child));
  },
  IfStatement (node) {
    let code = `if (${generate(node.test)}) ${generate(node.consequent)}`;
    if (node.alternative) {
      code += `else ${generate(node.alternative)}`;
    }
    return code;
  },
  BlockStatement (node) {
    let code = node.body.map(child => generate(child));
    code = `{ ${code} }`;
    return code;
  },
  ......
};
function generate(node) {
  return types[node.type](node);
}
const ast = Babel.parse(...);            // 将代码解析成语法树
const generatedCode = generate(ast);     // 将语法树重新组合成代码
```

### 参考文献
[Babel是如何读懂JS代码的](https://zhuanlan.zhihu.com/p/27289600)