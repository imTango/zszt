//
//  AppDelegate.m
//  众商智推
//
//  Created by 杨 on 16/4/8.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchingViewController.h"
#import "NewfeatureViewController.h"

#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "WXApi.h"
#import "WXApiObject.h"
//#import "WXApiManager.h"
#import "ZSTabBarViewController.h"
#import "BaiduMobAdSDK/BaiduMobAdSplash.h"

@interface AppDelegate ()<BaiduMobAdSplashDelegate>

@property (nonatomic, strong) BaiduMobAdSplash *splash;

@property (nonatomic, retain) UIView *customSplashView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //友盟appKey   改了两处5770d3e6e0f55ab09e00079c  原来的为56a7007c67e58ebe480014d4    webViewcontroller
    [UMSocialData setAppKey:@"5770d3e6e0f55ab09e00079c"];
    
//    //设置微信分享Appkey
    [UMSocialWechatHandler setWXAppId:@"wx9c560386596469e2" appSecret:@"a9d1210a2f185bb77e3b1c49c6de5731" url:@"https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxf0e81c3bee622d60&redirect_uri=http%3A%2F%2Fnba.bluewebgame.com%2Foauth_response.php&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect"];
    //设置QQ分享的appkey
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"b65df68fd13efe2842da5e141bc8d8a9" url:nil];
    //向微信注册wxd930ea5d5a258f4f
    [WXApi registerApp:@"wx9c560386596469e2" withDescription:@"demo 2.0"];
    
    //返回的Url网址   微信消息url地址
//    http://www.umeng.com/social
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.设置跟控制器
    NSString *key = @"CFBundleVersion";
    //上一次使用的版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //当前软件的版本号（从Info.plist中获取）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        //第二次的时候直接显示开平广告  不加载新特性了
//        LaunchingViewController *launchVC = [[LaunchingViewController alloc] init];
//        self.window.rootViewController = launchVC;
        
        
        //        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.window.rootViewController = [[ZSTabBarViewController alloc] init];
        [self.window makeKeyAndVisible];
        
        BaiduMobAdSplash *splash = [[BaiduMobAdSplash alloc] init];
        splash.delegate = self;
        splash.AdUnitTag = @"2058492";
        splash.canSplashClick = YES;
        self.splash = splash;
        
        //可以在customSplashView上显示包含icon的自定义开屏
        self.customSplashView = [[UIView alloc]initWithFrame:self.window.frame];
        self.customSplashView.backgroundColor = [UIColor whiteColor];
        [self.window addSubview:self.customSplashView];
        
        CGFloat screenWidth = self.window.frame.size.width;
        CGFloat screenHeight = self.window.frame.size.height;
        
        //在baiduSplashContainer用做上展现百度广告的容器，注意尺寸必须大于200*200，并且baiduSplashContainer需要全部在window内，同时开机画面不建议旋转
        UIView * baiduSplashContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 10, screenWidth, screenHeight - 50)];
        [self.customSplashView addSubview:baiduSplashContainer];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth*0.5 - 40, screenHeight - 40, 80, 20)];
        label.text = @"众商智推";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:20];
        [self.customSplashView addSubview:label];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth - 80, screenHeight - 40, 80, 20)];
        [btn setTitle:@"进入" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"right_icon"] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25);
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        [btn addTarget:self action:@selector(removeGuangGao) forControlEvents:UIControlEventTouchUpInside];
        [self.customSplashView addSubview:btn];
        
        //在的baiduSplashContainer里展现百度广告
        [splash loadAndDisplayUsingContainerView:baiduSplashContainer];
        
    }else {
        //这次打开的版本和上次不一样，显示新特性
        self.window.rootViewController = [[NewfeatureViewController alloc] init];
        //将当前的版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.window makeKeyAndVisible];
    }
    
    //个人广告条存储地址
    NSMutableDictionary * infoDic = [NSMutableDictionary dictionary];
    infoDic = (NSMutableDictionary*)[NSKeyedUnarchiver unarchiveObjectWithFile:kPath];
    if (infoDic == nil) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [NSKeyedArchiver archiveRootObject:dic toFile:kPath];
    }else{
//        ZSLog(@"appdelegate:%@",infoDic);
//        [infoDic removeAllObjects];
        [NSKeyedArchiver archiveRootObject:infoDic toFile:kPath];
    }
    [self.window makeKeyAndVisible];
    
    return YES;
}
- (void)removeGuangGao
{
    [self splashDidDismissScreen:nil];
}

//应用的APPID
- (NSString *)publisherId {
    return @"ccb60059";
}
/**
 *  广告被点击
 */
- (void)splashDidClicked:(BaiduMobAdSplash *)splash {
    NSLog(@"splashDidClicked");
}
/**
 *  广告详情页消失
 */
- (void)splashDidDismissLp:(BaiduMobAdSplash *)splash {
    NSLog(@"splashDidDismissLp");
}
/**
 *  广告展示结束
 */
- (void)splashDidDismissScreen:(BaiduMobAdSplash *)splash {
    NSLog(@"splashDidDismissScreen");
    [self removeSplash];
}
/**
 *  广告展示成功
 */
- (void)splashSuccessPresentScreen:(BaiduMobAdSplash *)splash {
    NSLog(@"splashSuccessPresentScreen");
}
/**
 *  广告展示失败
 */
- (void)splashlFailPresentScreen:(BaiduMobAdSplash *)splash withError:(BaiduMobFailReason)reason {
    NSLog(@"splashlFailPresentScreen withError %d", reason);
    [self removeSplash];
}
/**
 *  展示结束or展示失败后, 手动移除splash和delegate
 */
- (void) removeSplash {
    if (self.splash) {
        self.splash.delegate = nil;
        self.splash = nil;
        [self.customSplashView removeFromSuperview];
    }
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//}
//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return  [UMSocialSnsService handleOpenURL:url];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options{
    return [UMSocialSnsService handleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
