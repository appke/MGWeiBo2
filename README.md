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
#### 代码添加子控制器

```swift
AppDelegate.swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // 设置UITabBar全局颜色
    UITabBar.appearance().tintColor = UIColor.orange
    
    // 创建window
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = MainViewController()
    window?.makeKeyAndVisible()
    
    return true
}
```

```swift
MainViewController.swift
// 函数重载 private
private func addChildViewController(_ childVc: UIViewController, title : String, imageName : String) {
    // 设置chileVc属性
    childVc.title = title;
    childVc.tabBarItem.image = UIImage(named: imageName);
    // .withRenderingMode(.alwaysOriginal) 文字还是蓝色
    childVc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
    
    // 包装导航控制器
    let childNav = UINavigationController(rootViewController: childVc)
    addChildViewController(childNav)
}
```
![](/Screenshot/tabbar.png)