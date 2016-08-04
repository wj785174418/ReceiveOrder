//
//  AppDelegate.m
//  ReceiveOrder
//
//  Created by HuayuNanyan on 16/7/25.
//  Copyright © 2016年 HuayuNanyan. All rights reserved.
//

#import "AppDelegate.h"
#import "Login.h"
#import "WJPromptLabel.h"
#import "UMessage.h"

static AFHTTPSessionManager *HTTPManager;
@interface AppDelegate ()
@property (weak, nonatomic) WJPromptLabel *promptLabel;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [userDefaults valueForKey:@"userID"];
    if (userID == nil) {
        UINavigationController *rootViewController = (UINavigationController *)self.window.rootViewController;
        
        Login *login = [rootViewController.storyboard instantiateViewControllerWithIdentifier:@"Login"];
        
        [rootViewController pushViewController:login animated:NO];
    }
    
    //键盘window添加提示Label
    self.promptLabel = [WJPromptLabel sharedPromptLabel];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showPromptLabel:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showPromptLabel:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(windowAddPromptLabel:) name:UIWindowDidBecomeVisibleNotification object:self.window];
    
    //集成UMessage
    
    //设置APPKey
    [UMessage startWithAppkey:@"579b2305e0f55a24a2001e8d" launchOptions:launchOptions];
    
    [UMessage registerForRemoteNotifications];
    [UMessage setLogEnabled:YES];
    [UMessage setBadgeClear:NO];
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo{
    NSLog(@"%@",userInfo);
    [UMessage didReceiveRemoteNotification:userInfo];
}
/**
 *  AFHTTPSessionManager单例获取
 *
 *  @return AFHTTPSessionManager的单例
 */
+ (AFHTTPSessionManager *)sharedHTTPManager{
    if (HTTPManager != nil) {
        return HTTPManager;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HTTPManager = [AFHTTPSessionManager manager];
    });
    return HTTPManager;
}

#pragma -mark showPromptLabel

- (void)showPromptLabel:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    //键盘弹入、弹出后frame
    NSValue *value = userInfo[UIKeyboardFrameEndUserInfoKey];
    
    CGFloat keyBoardEndY = value.CGRectValue.origin.y;
    
    if (keyBoardEndY == ScreenHeight) {
        [self.window addSubview:self.promptLabel];
    }else{
        [[[UIApplication sharedApplication].windows lastObject]addSubview:self.promptLabel];
    }
}

- (void)windowAddPromptLabel:(NSNotification *)notification{
    UIWindow *window = [notification object];
    [window addSubview:self.promptLabel];
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
