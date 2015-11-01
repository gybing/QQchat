//
//  AppDelegate.m
//  机器人
//
//  Created by gyh on 15/5/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "DDMenuController.h"
#import "ViewController.h"
#import "LeftViewController.h"
#import "NavigationController.h"

#import <iflyMSC/IFlyRecognizerViewDelegate.h>
#import <iflyMSC/IFlyRecognizerView.h>
#import <iflyMSC/IFlySpeechUtility.h>

#import <ShareSDK/ShareSDK.h>
#import"WeiboApi.h"
#import<TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"



@interface AppDelegate ()
@property(nonatomic,strong)ViewController *vc;
@property(nonatomic,strong)DDMenuController *dd;

@end

@implementation AppDelegate


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [ShareSDK registerApp:@"7f2688ca1e49"];
    [ShareSDK connectSMS];
    [ShareSDK connectMail];
    /*Sina*/
    [ShareSDK connectSinaWeiboWithAppKey:@"966765626" appSecret:@"d128a3dd0884ba5f788e7a2edaf811c8" redirectUri:@"http://www.baidu.com"];

    
    /*QQ好友分享 info里边要搞成16进制的*/
  //  [ShareSDK connectQZoneWithAppKey:@"1103540883" appSecret:@"l3C7NDm849haVGwY"];
  //  QQ微博   wb+ID
//    [ShareSDK connectQQWithQZoneAppKey:@"1103540883"
//                     qqApiInterfaceCls:[QQApiInterface class]
//                       tencentOAuthCls:[TencentOAuth class]];
//    [ShareSDK connectTencentWeiboWithAppKey:@"1103540883" appSecret:@"l3C7NDm849haVGwY" redirectUri:@"http://www.baidu.com"];
//    /*wecat微信*/
//    [ShareSDK connectWeChatSessionWithAppId:@"wxc9b8205009dae367" wechatCls:[WXApi class]];
//    /*微信朋友圈95aa02d2dc058768901c8d1ca3b3c56b*/
//    [ShareSDK connectWeChatTimelineWithAppId:@"wxc9b8205009dae367" wechatCls:[WXApi class]];
    
    

    //语音接口
    NSString *initstring = [[NSString alloc]initWithFormat:@"appid=%@",@"555f497c" ];
    [IFlySpeechUtility createUtility:initstring];
    
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.vc = [story instantiateViewControllerWithIdentifier:@"MainViewControl"];

    LeftViewController *lf = [story instantiateViewControllerWithIdentifier:@"LeftViewController"];
    self.dd = [[DDMenuController alloc]init];
    self.dd.leftViewController = lf;
    self.dd.rightViewController = nil;
    NavigationController *navic = [[NavigationController alloc]initWithRootViewController:self.vc];
    self.dd.rootViewController= navic;
    self.window.rootViewController = self.dd;
    
    return YES;
}



@end
