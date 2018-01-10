//
//  SHWebViewWithFooterController.m
//  WebViewWithFooter
//
//  Created by 宋航 on 2018/1/5.
//  Copyright © 2018年 zbt－大数据中心. All rights reserved.
//

#import "SHWebViewWithFooterController.h"
@interface SHWebViewWithFooterController ()<UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
//遮盖
@property (nonatomic, strong) UILabel *loadingView;
//底部添加的视图
@property (nonatomic,strong)UIControl *bottomView;
@end

@implementation SHWebViewWithFooterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.webView = [[UIWebView alloc]init];
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.delegate= self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.wercraft.top/yqp-images/pc_page/news/070010EE3A1EF13E2AE4D70A060CD122.jsp"]]];
    self.webView.scrollView.delegate = self;
    
    self.webView.frame = CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height, self.view.bounds.size.width,self.view.bounds.size.height-([UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height));
    [self.view addSubview:self.webView];
    //状态栏高度
    float stateHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    //导航栏高度
    float naviHeight = self.navigationController.navigationBar.bounds.size.height;
    //标签控制器高度
    float tabbarHeight = self.tabBarController.tabBar.bounds.size.height;
    
    NSLog(@"....%f..%f...%f",stateHeight,naviHeight,tabbarHeight);
    
    //UIWebView中的层次
    // UIWebView中的层次   UIWebView -->_UIWebViewScrollView--UIWebBrowserView
    
    for (UIView *view in self.webView.subviews) {
        
        NSLog(@"111  %@",view);
    }
    
    for (UIView *view in self.webView.scrollView.subviews) {
        
        NSLog(@"222  %@",view);
    }
    
    
    //不想引入框架增加工程大小 随便写的遮盖
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    self.loadingView = [UILabel new];
    self.loadingView.text = @"正在加载...";
    self.loadingView.textAlignment= NSTextAlignmentCenter;
    self.loadingView.backgroundColor = [UIColor yellowColor];
    CGRect frame = CGRectMake(0,[UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height);
    self.loadingView.frame = frame;
    [keyWindow addSubview:self.loadingView];
    
    
    
}
#pragma mark - 监听到加载成功后添加
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    CGSize contentSize = self.webView.scrollView.contentSize;
    float topHeight = 100;
    float bottomHeight = 200;
    
    //顶部视图
    UIView *topView  = [UIView new];
    topView.frame = CGRectMake(0, 0, self.view.bounds.size.width, topHeight);
    topView.backgroundColor = [UIColor greenColor];
    [self.webView.scrollView addSubview:topView];
    
    //重新设置展示网页的frame
    UIView *innerWebView = self.webView.scrollView.subviews.firstObject;
    CGRect frame = innerWebView.frame;
    frame.origin.y = CGRectGetMaxY(topView.frame);
    innerWebView.frame = frame;
    
    //添加底部视图
    self.bottomView = [[UIControl alloc]init];
    [self.bottomView addTarget:self action:@selector(addViewHeight) forControlEvents:UIControlEventTouchUpInside];
    self.bottomView.backgroundColor = [UIColor redColor];
    self.bottomView.frame = CGRectMake(0, contentSize.height + topHeight, self.view.bounds.size.width, bottomHeight);
    self.webView.scrollView.contentSize = CGSizeMake(contentSize.width, contentSize.height + topHeight + bottomHeight);
    [self.webView.scrollView addSubview:self.bottomView];
    
    [self.loadingView removeFromSuperview];
}
#pragma mark - 改变底部视图高度
static float addHeight = 20;
- (void)addViewHeight
{

    self.bottomView.frame = CGRectMake(0, CGRectGetMinY(self.bottomView.frame), self.view.bounds.size.width, self.bottomView.frame.size.height + addHeight);
    self.webView.scrollView.contentSize = CGSizeMake(self.webView.scrollView.contentSize.width, self.webView.scrollView.contentSize.height + addHeight);
}
- (void)dealloc
{
    if (self.loadingView)
    {
        [self.loadingView removeFromSuperview];
    }
    
}
@end
