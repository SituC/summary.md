### 背景

最近跟朋友开发一个vue3的ui库，希望使用 `vite` `tsx` `vue3`等技术开发，并且可以边开发边通过vuepress文档查看到最新的组件，以下是环境搭建的一些总结

---
### 使用技术
- [vuepress-vite](https://v2.vuepress.vuejs.org/zh/guide/bundler.html#vite)
- [vite](https://cn.vitejs.dev/)
- [vue3](https://v3.cn.vuejs.org/guide/introduction.html)
- [tsx](https://github.com/vuejs/jsx) - 待更新
- [esbuild](https://esbuild.github.io/) - 待更新
- [shelljs](https://github.com/shelljs/shelljs) - 待更新
---
### 环境搭建
#### 1.  搭建浏览文档的模块
我们都知道vue的官方文档是使用`vuepress`展示的，vuepress的展示风格因为经常查看vue文档的缘故，已经特别熟悉了，因此选择vuepress，但是既然都使用了vue3来开发组件了，那能不能使用vite来构建vuepress项目呢，答案可以的，官方vuepress的`2.0版本`也提供了此方式。

首先创建 my-ui 文件夹并进入
```sh
# my-ui根目录

# 环境初始化
yarn init
# 安装vuepress、vuepress-vite
yarn add -D vuepress@next vuepress-vite@next
```
vuepress在运行时会生成缓存目录`.cache`以及临时目录`.temp`，这些文件都不需要上传远端，所以都得添加进`.gitignore`文件中
创建.gitignore
```.gitignore
node_modules
docs/.vuepress/.cache
docs/.vuepress/.temp
```
创建`docs`目录以及docs中创建`.vuepress`目录以及`READMD.md`文件，并在`.vuepress`中创建vuepress的初始化文件`config.ts`
结构如下
```
|-- my-ui
    |-- docs
    |   |-- .vuepress
    |       |-- config.ts
    |   |-- README.md
```
vuepress文档展示路由规则将 `docs` 目录作为你的 sourceDir ，例如你在运行 `vuepress docs:dev` 命令。此时，你的 Markdown 文件对应的路由路径为：

相对路径 | 路由路径
---|---
/README.md | /
/guide/README.MD | /guide/
/guide/page.md | /guide/page.html

>  因此，我们在`docs/README.md`文件中写内容，理论项目启动首页就是该内容

vuepress要想使用vite打包，官方提供了方式，需要修改配置文件，如下
```ts
// docs/.vuepress/config.ts
import { defineUserConfig } from 'vuepress-vite'
import type { DefaultThemeOptions, ViteBundlerOptions } from 'vuepress-vite'

export default defineUserConfig<DefaultThemeOptions, ViteBundlerOptions>({
  // 使用vite模式打包
  bundler: '@vuepress/vite',
  bundlerConfig: {
    // vite 打包工具的选项
  },
})
```
在`package.json`中新增vuepress脚本命令
```package.json
{
  "scripts": {
    "docs:dev": "vuepress dev docs",
    "docs:build": "vuepress build docs"
  }
}
```
至此，文档浏览模块初始化完毕，运行`yarn docs:dev`看看效果吧

![home.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/98e73a521c2842bf8dc0084ba0d8a741~tplv-k3u1fbpfcp-watermark.image)


#### 2. 通过vite搭建vue3

或许有的人会疑惑vue3和vuepress之间该怎么共存，是在vuepress中写vue3还是vue3中写vuepress呢？答案是共存关系，举个例子其实就是一个项目中有react和vue两种框架，两种框架运用互相独立，互不影响，只是之间**通过打包**，让其中一个项目能够直接访问另外一个项目的内容

vite提供了vue-ts模板安装的方式`demo`为项目文件夹名称
```sh
# my-ui 根目录
yarn create @vitejs/app demo --template vue-ts
```

ui库一般是由文档展示模块`docs`、组件展示模块`example`、组件包模块`packages`构成。流程也就是：**在packages中开发，在example中查看，在docs中展示**。所以我们需要修改刚刚创建的vite项目结构

```md
|-- my-ui                                                                    |-- my-ui
    |-- package.json                                                             |-- package.json
    |-- yarn.lock                                                                |-- yarn.lock
    |-- docs                                                                     |-- docs
    |   |-- README.md                                                            |   |-- README.md
    |   |-- .vuepress                                                            |   |-- .vuepress
    |       |-- config.ts                                                        |       |-- config.ts
    |-- demo                                                                     |-- example
        |-- .gitignore                                                               |-- assets     
        |-- index.html                                                               |-- components 
        |-- package.json                                                             |-- App.vue
        |-- README.md                                             =>                 |-- main.ts
        |-- tsconfig.json                                                            |-- shims-vue.d.ts     
        |-- vite.config.ts                                                           |-- vite-env.d.ts
        |-- public                                                               |-- favicon.ico
        |   |-- favicon.ico                                                      |-- index.html
        |-- src                                                                  |-- tsconfig.json
            |-- App.vue                                                          |-- vite.config.ts
            |-- main.ts                                                          |-- .gitignore
            |-- shims-vue.d.ts                                                   |-- README.md
            |-- vite-env.d.ts                                                  
            |-- assets                                                  
            |-- components                                                  

```
简单来说，就是将vite项目demo中的所有文件移动到根目录中，`favicon.icon`移动到根目录，删除`public`，`src`移动到根目录，改名为`example`，修改`index.html`中对`main.ts`和`favicon.icon`的引用路径，最后删除demo目录
> 注意修改移动项目过后的引用路径，以及将vite的`package.json` `.gitignore`和vuepress的`package.json` `.gitignore`等需要公用的文件整合

修改过后的package.json如下

```json
{
  "name": "my-ui",
  "version": "1.0.0",
  "main": "index.js",
  "license": "MIT",
  "scripts": {
    "vite:vue": "vite",
    "vite:build": "vue-tsc --noEmit && vite build",
    "vite:serve": "vite preview",
    "docs:dev": "vuepress dev docs",
    "docs:build": "vuepress build docs"
  },
  "dependencies": {
    "vue": "^3.0.5"
  },
  "devDependencies": {
    "vuepress": "^2.0.0-beta.21",
    "vuepress-vite": "^2.0.0-beta.21",
    "@vitejs/plugin-vue": "^1.2.4",
    "@vue/compiler-sfc": "^3.0.5",
    "typescript": "^4.3.2",
    "vite": "^2.4.0",
    "vue-tsc": "^0.0.24"
  }
}

```

综上，vite环境搭建完毕，运行`yarn vite:vue`查看吧（ps:都看烂了的vue初始项目的首页就不展示啦）