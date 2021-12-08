// 柯里化的作用优化了tree shaking
// vue3挂载
import App from './App.vue'
const app = createApp(App)
app.mount('#app')


// 源码解读 - 柯里化的运用
// 渲染相关的一些配置，比如更新属性的方法，操作 DOM 的方法
const rendererOptions = {
  patchProp,
  ...nodeOps
}
let renderer

function ensureRenderer() {
  return renderer || (renderer = createRenderer(rendererOptions))
}

function createRenderer(options) {
  return baseCreateRenderer(options)
}

function baseCreateRenderer(options) {
  function render(vnode, container) {
    // 组件渲染的核心逻辑
  }

  return {
    render,
    createApp: createAppApi(render)
  }
}

function createAppApi(render) {
  return function createApp(rootComponent, rootProps = null) {
    const app = {
      _component: rootComponent,
      _props: rootProps,
      mount(rootContainer) {
        const vnode = createVNode(rootComponent, rootProps)
        render(vnode, rootContainer)
        app._container = rootContainer
        return vnode._component.proxy
      }
    }
    return app
  }
}

const createApp = ((...args) => {
  const app = ensureRenderer().createApp(...args)
  const { mount } = app
  app.mount = (containerOrSelector) => {
    // ...
  }
  return app
})