```typescript
type User = {
  id: number;
  kind: string;
};

function makeCustomer<T extends User>(u: T): T {
  // Error（TS 编译器版本：v4.4.2）
  // Type '{ id: number; kind: string; }' is not assignable to type 'T'.
  // '{ id: number; kind: string; }' is assignable to the constraint of type 'T', 
  // but 'T' could be instantiated with a different subtype of constraint 'User'.
  return {
    id: u.id,
    kind: 'customer'
  }
}

```
以上代码为什么会提示错误，应该如何解决上述问题？

解答：
因为`extends`只是继承了User的属性，但是函数返回值却限制了返回类型只有id和kind，这显然是不符合泛型的传入与传出相同的概念，所以解决方法有两种

- 限制返回类型只能id和kind
- 拓展返回类型

```typescript
type User = {
  id: number;
  kind: string;
};

function makeCustomer<T extends User>(u: T): T {
  return {
    ...u, // 将参数剩余属性返回
    id: u.id,
    kind: 'customer'
  }
}
```

```typescript
type User = {
  id: number;
  kind: string;
};

function makeCustomer<T extends User>(u: T): CallBack<T, User> {
  return {
    id: u.id,
    kind: 'customer'
  }
}
type CallBack<T extends User, U> = {
  [K in keyof U as K extends keyof T ? K : never]: U[K]
}
makeCustomer({id: '', kind: '', name: ''})
```