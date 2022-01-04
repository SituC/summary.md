any: 不会进行类型校验，会造成意料之外的错误。比如
```ts
let obj: any = {
  getName: 'lwl'
}
obj.getAge()
```

unknown: 会进行类型校验，所以需要缩小范围进行校验，比如
```ts
let str: unknown = 123
(str as string).toLowerCase()
```

所以在不知道类型的情况下，最好是用unknown代替any来进行类型校验