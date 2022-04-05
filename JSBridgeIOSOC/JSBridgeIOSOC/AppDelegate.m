//
//  AppDelegate.m
//  JSBridgeIOSOC
//
//  Created by BeiChen.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property(nonatomic,strong) ViewController * viewController;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*
        为了去掉main.sb ,做了两个操作，
        1.删除了plist里的main sb项目
        2.在此处设置了window和对应控制器
     */

    //初始化控制器
    self.viewController = [[ViewController alloc]init];
    //初始化window
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //设置rootViewController
    self.window.rootViewController = self.viewController;
    //给窗口添加背景色
    self.window.backgroundColor = [UIColor whiteColor];
    //因为只有一个主窗口，这是个快捷方式，让被使用对象的主窗口显示在最前端
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    // 当应用重新被前台调用时会走到这个生命周期方法，所以在这里进行 webView 的刷新
    if ([self.window.rootViewController isKindOfClass:[ViewController class]]) {
        ViewController *controller = (ViewController *)(self.window.rootViewController);
        if (controller.webView) {
            [controller.webView reload];
        }
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
