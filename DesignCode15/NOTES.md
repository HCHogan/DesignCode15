# Notes

## View stuffs

在 Swift 中，`@ViewBuilder` 属性包装器实际上是一个语法糖，它在编译时会被转换为一个返回 `some View` 的函数。
当我们使用 `@ViewBuilder` 标记一个函数或闭包参数时，编译器会将其转换为一个返回 `some View` 的函数，并将传递给该参数的多个视图组合成一个视图层次结构。
下面是一个示例，展示了 `@ViewBuilder` 去糖后的代码：
```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello")
            Text("World")
        }
    }
}
```

上面的代码经过去糖后，实际上等价于以下代码：
```swift
struct ContentView: View {
    var body: some View {
        ViewBuilder.buildBlock(
            Text("Hello"),
            Text("World")
        )
    }
}
```
