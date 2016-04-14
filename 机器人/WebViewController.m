//
//  WebViewController.m
//  机器人
//
//  Created by gyh on 15/6/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#define URL @"http://m.image.so.com/i?q=%E7%BE%8E%E5%A5%B3"

#import "WebViewController.h"
#import "UIBarButtonItem+gyh.h"


@interface WebViewController ()<UIWebViewDelegate>

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor blackColor];
    UIWebView *web = [[UIWebView alloc]init];
    web.frame = self.view.bounds;
    web.delegate = self;
    NSURL *url = [NSURL URLWithString:URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [web loadRequest:request];
    [self.view addSubview:web];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWithIcon:@"dismiss" highIcon:nil target:self action:@selector(cancel)];
   
}

-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
