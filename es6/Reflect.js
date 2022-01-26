/* 
Reflect对象与Proxy对象一样，
也是 ES6 为了操作对象而提供的新 API。
Reflect对象的设计目的有这样几个。

1. Reflect拥有Object的一些内部方法，比如Object.defineProperty
并且未来支队Reflect做更新。
2. 修改Object方法的返回结果，让其变得更合理。
以前Object.defineProperty(obj, name, desc)在无法定义属性时，会抛出一个错误，
而Reflect.defineProperty(obj, name, desc)则会返回false。
**/
// 老写法
try {
  Object.defineProperty(target, property, attributes);
  // success
} catch (e) {
  // failure
}

// 新写法
if (Reflect.defineProperty(target, property, attributes)) {
  // success
} else {
  // failure
}

/**
 * 3 让Object操作都变成函数行为。某些Object操作是命令式，比如name in obj和delete obj[name]，
 * 而Reflect.has(obj, name)和Reflect.deleteProperty(obj, name)让它们变成了函数行为。
 */
// 老写法
'assign' in Object // true
delete obj.name
// 新写法
Reflect.has(Object, 'assign') // true
Reflect.deleteProperty(obj, 'name')

/**
 * 4 Reflect对象的方法与Proxy对象的方法一一对应
 * 不管Proxy怎么修改默认行为，你总可以在Reflect上获取默认行为。
 */
 Proxy(target, {
  set: function(target, name, value, receiver) {
    var success = Reflect.set(target, name, value, receiver);
    if (success) {
      console.log('property ' + name + ' on ' + target + ' set to ' + value);
    }
    return success;
  }
});

var loggedObj = new Proxy(obj, {
  get(target, name) {
    console.log('get', target, name);
    return Reflect.get(target, name);
  },
  deleteProperty(target, name) {
    console.log('delete' + name);
    return Reflect.deleteProperty(target, name);
  },
  has(target, name) {
    console.log('has' + name);
    return Reflect.has(target, name);
  }
});
