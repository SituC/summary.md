
1. require是符合commonjs规范，适用于服务器环境，import符合es6 module规范，AMD是适用于浏览器环境。
2. commonjs和amd都是运行时确定依赖关系，module是编译时确定依赖关系
3. 
1. require是内部会创建export去接受js需要返回的变量