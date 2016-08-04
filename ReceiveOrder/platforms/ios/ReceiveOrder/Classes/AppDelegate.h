//
//  AppDelegate.h
//  ReceiveOrder
//
//  Created by HuayuNanyan on 16/7/25.
//  Copyright © 2016年 HuayuNanyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AFHTTPSessionManager *)sharedHTTPManager;

@end

