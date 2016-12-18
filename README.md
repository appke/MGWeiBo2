# MGWeiBo2
#### 自定义Log
```swift
/// 全局打印函数
func MGLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName):[\(funcName)](\(lineNum))-\(message)")
    #endif
}
```



