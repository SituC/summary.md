function myBind(ctx, ...args) {
  return (...newArgs) => this.call(ctx, ...args, ...newArgs)
}