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

//#import <iflyMSC/IFlyRecognizerViewDelegate.h>
//#import <iflyMSC/IFlyRecognizerView.h>
//#import <iflyMSC/IFlySpeechUtility.h>

//#import <ShareSDK/ShareSDK.h>
//#import"WeiboApi.h"
//#import<TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/TencentOAuth.h>
//#import "WXApi.h"
//#import "WeiboSDK.h"
#import <UIKit/UIKit.h>

#import "UMessage.h"




@interface AppDelegate ()
@property(nonatomic,strong)ViewController *vc;
@property(nonatomic,strong)DDMenuController *dd;

@end

@implementation AppDelegate





- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //set AppKey and AppSecret
    [UMessage startWithAppkey:@"55caa69467e58e8fe8005878" launchOptions:launchOptions];
    
    #if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"options:NSNumericSearch] != NSOrderedAscending)
    {
        //register remoteNotification types （iOS 8.0及其以上版本）
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types (iOS 8.0以下)
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types (iOS 8.0以下)
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    //for log
    [UMessage setLogEnabled:YES];
    


    //语音接口
    NSString *initstring = [[NSString alloc]initWithFormat:@"appid=%@",@"555f497c" ];
//    [IFlySpeechUtility createUtility:initstring];
    
    
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


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [UMessage registerDeviceToken:deviceToken];
    
    
}




//处理收到的消息推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UMessage didReceiveRemoteNotification:userInfo];
}






@end
