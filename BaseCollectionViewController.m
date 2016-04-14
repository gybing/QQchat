//
//  BaseViewController.m
//  机器人
//
//  Created by gyh on 15/6/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController ()

@end

@implementation BaseCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUIAppearce];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleThemeChanged) name:Notice_Theme_Changed object:nil];
}


-(void)handleThemeChanged
{
    ThemeManager *defaultManager = [ThemeManager sharedInstance];
    [self.navigationController.navigationBar setBackgroundImage:[defaultManager themedImageWithName:@"navigationBar"] forBarMetrics:UIBarMetricsDefault];
    self.collectionView.backgroundColor = [defaultManager themeColor];
    [self configUIAppearce];
}


#pragma mark - 主题切换
-(void)configUIAppearce
{
    
}

@end
