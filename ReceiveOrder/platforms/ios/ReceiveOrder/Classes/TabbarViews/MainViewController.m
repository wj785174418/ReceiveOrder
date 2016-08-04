/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  MainViewController.h
//  ReceiveOrder
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import "MainViewController.h"
#import "UIView+MJExtension.h"
#import <MJRefresh.h>

@interface MainViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) UIWebView *webView;

@property (strong, nonatomic) UIView *customView;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    _customView = [[UIView alloc]init];
//    
//    _customView.frame = CGRectMake(0, 0, 36, 36);
//    _customView.backgroundColor = [UIColor redColor];
//    _customView.layer.masksToBounds = YES;
//    _customView.layer.cornerRadius = 18;
//    
//    UIButton *backImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    [backImageBtn setBackgroundImage:[UIImage imageNamed:@"icon-small"] forState:UIControlStateNormal];
//    
//    backImageBtn.frame = _customView.bounds;
//    
//    [_customView addSubview:backImageBtn];
//    
//    [backImageBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //------------------------------
//    self.tabBarController.title = @"我的工单";
    
    [self setWebViewAttributes];
    
//    [self navigationBarAddLeftBarBtn];
    
}

/**
 *  添加导航栏返回按钮
 */
- (void)navigationBarAddLeftBarBtn{
    
//    self.tabBarController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(clickBackBtn)];
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:_customView];
    
    self.tabBarController.navigationItem.leftBarButtonItem = leftBarBtn;
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBtn)];
    
    self.tabBarController.navigationItem.rightBarButtonItem = rightBarBtn;
}

- (void)clickRightBtn{
    
}

- (void)clickBackBtn{
    if ([_webView canGoBack]) {
        [_webView goBack];
    }else{
        [_webView stringByEvaluatingJavaScriptFromString:@"$(\"#login-btn\").click()"];
    }
}

/**
 *  设置webView的相关属性
 */
- (void)setWebViewAttributes{
    _webView = (UIWebView *)self.aWebView;
    
    _webView.backgroundColor = [UIColor whiteColor];
    
    CGRect webViewFrame = _webView.frame;
    webViewFrame.size.height -= 49;
    _webView.frame = webViewFrame;
    
//    _webView.delegate = self;
    
    //添加MJRefresh
//    _webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [_webView reload];
//    }];
//    
//    [(MJRefreshNormalHeader *)_webView.scrollView.mj_header setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    MJRefreshNormalHeader *header = (MJRefreshNormalHeader *)_webView.scrollView.mj_header;
    
    if ([header.stateLabel.text isEqualToString:@"正在刷新..."]) {
        header.stateLabel.text = @"☑刷新成功";
        [self performSelector:@selector(webHeaderEndRefreshing) withObject:nil afterDelay:0.7];
    }
}

- (void)webHeaderEndRefreshing{
    [_webView.scrollView.mj_header endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}


/* Comment out the block below to over-ride */

/*
- (UIWebView*) newCordovaViewWithFrame:(CGRect)bounds
{
    return[super newCordovaViewWithFrame:bounds];
}
*/

@end

@implementation MainCommandDelegate

/* To override the methods, uncomment the line in the init function(s)
   in MainViewController.m
 */

#pragma mark CDVCommandDelegate implementation

- (id)getCommandInstance:(NSString*)className
{
    return [super getCommandInstance:className];
}

- (NSString*)pathForResource:(NSString*)resourcepath
{
    return [super pathForResource:resourcepath];
}

@end

@implementation MainCommandQueue

/* To override, uncomment the line in the init function(s)
   in MainViewController.m
 */
- (BOOL)execute:(CDVInvokedUrlCommand*)command
{
    return [super execute:command];
}

@end
