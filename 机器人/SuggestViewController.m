//
//  SuggestViewController.m
//  机器人
//
//  Created by gyh on 15/6/4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SuggestViewController.h"
#import "ThemeManager.h"
#import "MBProgressHUD+MJ.h"

@interface SuggestViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UIButton *suggest;
- (IBAction)Suggest;

@end

@implementation SuggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupinit];
   
}

-(void)setupinit
{
     self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    
    
    ThemeManager *man = [ThemeManager sharedInstance];
    self.suggest.backgroundColor = [man themeColor];
    
}

- (IBAction)Suggest {
    
    if (!self.textview.text.length == 0) {
        [MBProgressHUD showSuccess:@"意见反馈成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [MBProgressHUD showError:@"反馈内容不能为空"];
    }
    
}
@end
