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
//  NativeHtmlTest
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import "MainViewController.h"
#import <UIView+MJExtension.h>
#import <MJRefresh.h>

@interface MainViewController ()
@property (weak, nonatomic) UIWebView *myWebView;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(webViewDidLoaded) name:@"webViewDidLoaded" object:nil];
    
    [self setWebViewAttributes];
}

- (void)setWebViewAttributes{
    self.myWebView = (UIWebView *)self.webView;
    
    CGRect frame = self.myWebView.frame;
    frame.size.height -= 49;
    self.myWebView.frame = frame;
//    self.myWebView.scrollView.bounces = NO;
    
    MJRefreshHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:2];
    }];
    
    UIScrollView *webScroll = self.myWebView.scrollView;
    
    webScroll.mj_header = header;
    
    webScroll.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);

    UISearchBar *searchBar = [UISearchBar new];
    searchBar.frame = CGRectMake(0, -44, webScroll.mj_w, 44);
    [webScroll addSubview:searchBar];
    
//    self.myWebView.scrollView.backgroundColor = [UIColor whiteColor];
//
    header.ignoredScrollViewContentInsetTop = 40;
    
}

- (void)webViewDidLoaded{
    
    UIScrollView *webScroll = self.myWebView.scrollView;
    
    webScroll.contentOffset = CGPointMake(0, -64);
    
}

- (void)endRefreshing{
    [self.myWebView.scrollView.mj_header endRefreshing];
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
