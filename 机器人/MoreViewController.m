//
//  MoreViewController.m
//  机器人
//
//  Created by gyh on 15/5/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MoreViewController.h"
#import "UIImage+Extension.h"
#import "ThemeManager.h"
#import "ViewController.h"

@interface MoreViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation MoreViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];

}



-(void)setup
{
    self.tableView.scrollEnabled = NO;
    
    UIImageView *view = [[UIImageView alloc]init];
    [view setImage:[UIImage imageNamed:@"background"]];
    self.tableView.backgroundView = view;
    
    
    //设置按钮的背景颜色，随主题变换而变
    ThemeManager *man = [ThemeManager sharedInstance];
    [self.btn setBackgroundColor:[man themeColor]];
    
    [self.btn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)send
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
