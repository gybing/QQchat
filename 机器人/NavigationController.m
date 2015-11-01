//
//  NavigationController.m
//  机器人
//
//  Created by gyh on 15/5/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NavigationController.h"
#import "UIBarButtonItem+gyh.h"
#import "ThemeManager.h"


@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    

   ThemeManager *defaultManager = [ThemeManager sharedInstance];
//    [[UINavigationBar appearance]setBackgroundImage:[defaultManager themedImageWithName:@"navigationBar"] forBarMetrics:UIBarMetricsDefault];

    [[UINavigationBar appearance]setBarTintColor:[defaultManager themeColor]];
        
      //  [self.navigationItem.titleView setTintColor:[UIColor redColor]];
        
      //  UIImage *backgroundImage = [self imageWithColor:[defaultManager themeColor]];
     //   [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
        
 
    
   
}



//拦截所有push控制器
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWithIcon:@"navigationbar_back_os7" highIcon:nil target:self action:@selector(back)];
        

    [super pushViewController:viewController animated:animated];
}

-(void)back
{
    [self popViewControllerAnimated:YES];
    
}


@end
