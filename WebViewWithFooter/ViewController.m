//
//  ViewController.m
//  WebViewWithFooter
//
//  Created by 宋航 on 2018/1/5.
//  Copyright © 2018年 zbt－大数据中心. All rights reserved.
//

#import "ViewController.h"
#import "SHWebViewWithFooterController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    float stateHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    //导航栏高度
    float naviHeight = self.navigationController.navigationBar.bounds.size.height;
    //标签控制器高度
    float tabbarHeight = self.tabBarController.tabBar.bounds.size.height;
    
    NSLog(@"....%f..%f...%f",stateHeight,naviHeight,tabbarHeight);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(pushToSecondPage) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"下一页" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 100, 40);
    button.center = self.view.center;
    [self.view addSubview:button];
    
    
    NSString *aaa = @"张三  李四  王五  坚挺啊阿斯加德开飞机撒\n两地分居上课了底交付拉丝机对方快乐撒娇地离开飞机撒领导发萨\n洛克的积\n分卡拉世纪东方拉克丝";
    
    
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor yellowColor];
    label.text = aaa;
    label.font = [UIFont systemFontOfSize:13];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    

    
}

- (void)pushToSecondPage
{
    SHWebViewWithFooterController *webVC = [[SHWebViewWithFooterController alloc]init];
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:YES];
}


@end
