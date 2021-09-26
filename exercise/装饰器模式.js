// es5
const Model = (function () {
  let model = null
  return function () {
    if (!model) {
      model = document.createElement('div')
      model.innerHTML = '你还未登录'
      model.id = 'model'
      model.style.display = 'none'
      document.appendChild(model)
    }
    return model
  }
})()

function openModel () {
  const model = new Model()
  model.display = 'block'
}

// 新功能
function newFunction1 () {
  const btn = document.getElementById('open')
  btn.innerText = '快去登录'
}
function newFunction2 () {
  const btn = document.getElementById('open')
  btn.setAttribute('disabled', true)
}

function changeButtonStatus () {
  newFunction1()
  newFunction2()
}

document.getElementById('open').addEventListener('click', function () {
  openModel()
  changeButtonStatus()
})

document.getElementById('close').addEventListener('click', function () {
  const model = new Model()
  model.style.display = 'none'
})

// es6 单例模式 + 装饰器模式
class Modal {
  constructor (options) { 
    const fun = Modal.createInstance()
    if (!Modal.instance) {
      Modal.instance = new fun();
    }
    return Modal.instance;
  }
  static createInstance () { 
    return function () { 
      const modal = document.createElement('div')
      modal.innerHTML = '我是一个全局唯一的Modal'
      modal.id = 'modal'
      modal.style.display = 'none'
      document.body.appendChild(modal)
      return modal 
    }
  }
}

class OpenModal {
  open() {
    const modal = new Modal()
    modal.style.display = 'block'
  }
}

class Decorator {
  modal = null
  constructor(modal) {
    this.modal = modal
  }
  open() {
    this.modal.open()
    this.changeButtonStatus()
  }
  changeButtonStatus () {
    this.disableButton()
    this.changeButtonText()
  }
  disableButton() {
    const btn =  document.getElementById('open')
    btn.setAttribute("disabled", true)
  }
  changeButtonText() {
    const btn = document.getElementById('open')
    btn.innerText = '快去登录'
  }
}

const modal = new OpenModal()
const decorator = new Decorator(modal)

document.getElementById('open').addEventListener('click', function() {
  // openButton.onClick()
  // 此处可以分别尝试两个实例的onClick方法，验证装饰器是否生效
  decorator.onClick()
})

// es7装饰器模式
