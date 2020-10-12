# MGWeiBo2

- Swift5语法 
- 命名空间
- 读取Info.plist文件
- 读取json文件
- 异常处理try...throw
- Storyboard reference
- Swift事件监听
- xib创建view
- 自定义转场动画
- 重写控制器init方法
- 自定义空间init方法
- 用户属性
- 属性归档
- 微博模型 
- 属性监听器 
- 下拉刷新 
- 通知、代理、闭包 
- CollectionView
- 切换键盘，图文混排
- 图片浏览器



![](https://upload-images.jianshu.io/upload_images/185169-42730012e7a25fb6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![](https://upload-images.jianshu.io/upload_images/185169-4e0715e2ef61fc36.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![](https://upload-images.jianshu.io/upload_images/185169-3fcdec41ee9dfa7c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/185169-e91ad23091dce639.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



---

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