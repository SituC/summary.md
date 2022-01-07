/**
  比如一个表单，需要验证
  1姓名不大于10个字、必填
  2电话号码格式要正确、必填
  3年龄、非必填、如果有值必须是number
 **/
const form = {
  name: 'lwl',
  tel: '15988888888',
  age: null
}

// 定义验证策略
const validateRules = {
  name() {
    return form.name && form.name.length <= 10
  },
  tel() {
    const reg = /^1[0-9]{10}$/
    return reg.test(form.tel)
  },
  age() {
    return !form.age || (form.age && typeof form.age === 'number')
  }
}

class Validate {
  cache = []
  constructor(rules) {
    for (let method in rules) {
      this.cache.push(rules[method])
    }
  }
  // 验证事件
  check() {
    for (let valiFn of this.cache) {
      const data = valiFn()
      if (!data) {
        return false
      }
    }
    return true
  }
}

let validator = new Validate(validateRules)

const flg = validator.check()
console.log(flg)
