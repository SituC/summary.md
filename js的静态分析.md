## js运行过程

- 编译器（Compiler）：将源代码在运行之前编译成计算机能执行的机器码，由于要编译完所有源代码后在执行，所以编译器需要更多的内存存储机器码，但执行快；
- 解释器（Interpreter）：将源代码在运行时逐行解释执行，由于是一边解释一边执行，故启动快，执行慢；
- 抽象语法书（AST）：解析器（Parser)将源代码进行词法分析、语法分析后生成的抽象语法树，想要看生成的结果请戳：(astexplorer.net)[https://astexplorer.net/]
- 字节码（Bytecode）：又称作中间代码，在JS解析中就是从AST -> 字节码 -> 机器码，字节码是后面才被V8引擎引入的，主要目的是为了解决机器码带来的内存占用问题；
- 即时编译器（JIT）：简单的理解就是一段代码被解释器执行多次之后就会变成热点代码（HotSpot），热点代码会被编译器直接编译成机器码，当代码再次执行时直接运行机器码，从而达到提高性能的目的，这种编译器和解释器混合使用的技术被叫做即时编译。

#### 了解了几个基本概念后我们再来看看V8执行一段JS代码的过程图：
<img src="https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/d5c63cf4c71e49ad8b31e1bd1c037fe7~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp?">

#### 关于即时编译器的运行过程可以看下图：
<img src="https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9162d69b4d8241199e8d2f68ee43ab6a~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp?">


