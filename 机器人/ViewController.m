//
//  ViewController.m
//  机器人
//
//  Created by gyh on 15/5/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "MessageFrame.h"
#import "Message.h"
#import "MessageCell.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "AddView.h"
#import "UIBarButtonItem+gyh.h"
#import "MoreViewController.h"
#import "MessageCache.h"
//#import <iflyMSC/IFlyRecognizerViewDelegate.h>
//#import <iflyMSC/IFlyRecognizerView.h>
//#import <iflyMSC/IFlySpeechConstant.h>
#import "WebViewController.h"
#import "NavigationController.h"



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>
//{
//    IFlyRecognizerView *_iflyrReco;
//}

@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UIButton *sound;
-(IBAction)soundvoice;

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UITextField *inputView;
- (IBAction)addView;
@property (nonatomic, strong) NSMutableArray *messageFrames;
@property (weak,  nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, readwrite)UIInputView *input;

@end

@implementation ViewController

- (IBAction)addView
{
    
    UITextView *test = [[UITextView alloc]init];
    test.delegate = self;
    [self.btn addSubview:test];
    
    AddView *view = [[AddView alloc]initWithFrame:CGRectMake(0, 449, 375, 218)];
    
    test.inputAccessoryView = nil;
    test.inputView = nil;
    test.inputView = view;
    
    [test becomeFirstResponder];
    
    
    if (self.btn.tag == 0) {

         NSLog(@"1");

        self.btn.tag = 1;
        
    }else {
        NSLog(@"2");

        [test resignFirstResponder];
     
        self.btn.tag = 0;
        
    }
  
}

-(NSMutableArray *)messageFrames
{
    if (_messageFrames == nil) {

        _messageFrames = [[NSMutableArray alloc]init];
        
    }
    return _messageFrames;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.messageFrames = [MessageCache display];
 
    self.title = @"聊天";
    
    self.btn.tag = 0;
    
    [self.btn setImage:[UIImage imageNamed:@"chat_bottom_up_press"] forState:UIControlStateHighlighted];
    
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ItemWithIcon:@"navigationbar_friendsearch_os7" highIcon:@"navigationbar_friendsearch_highlighted_os7" target:self action:@selector(more)];

    // 去除分割线

    //设置背景图片

    self.tableview.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
   
  
    ThemeManager *manager = [ThemeManager sharedInstance];
    self.toolView.backgroundColor = [manager themeColor];

    
    self.tableview.alpha = 1.0;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.allowsSelection = NO; // 不允许选中
    self.tableview.delegate = self;
    
    //监听键盘的frame改变
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(click:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
    //设置输入框左边的间距
    self.inputView.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.inputView.leftViewMode = UITextFieldViewModeAlways;
    self.inputView.delegate = self;
    


    [self tongzhi];

}

/**
 *  导航栏右侧按钮
 */
-(void)more
{
    MoreViewController *mv = [[MoreViewController alloc]init];
//    mv.view.backgroundColor = [UIColor whiteColor];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    mv = [story instantiateViewControllerWithIdentifier:@"More"];
    [self.navigationController pushViewController:mv animated:YES];
}

-(void)tongzhi
{
    //点击图片进入webview
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(putweb:) name:@"NSPUTWEB" object:nil];
    //工具栏通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(event:) name:@"NSJOKE" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(event:) name:@"NSJJJ" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(event:) name:@"PHOTO" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(event:) name:@"aaa" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(event:) name:@"STORY" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(event:) name:@"WEATHER" object:nil];
    
}


-(void)putweb:(NSNotification *)noti
{
    WebViewController *vc = [[WebViewController alloc]init];
    NavigationController *na = [[NavigationController alloc]initWithRootViewController:vc];

    [self.view.window.rootViewController presentViewController:na animated:YES completion:nil];
   
}

-(void)event:(NSNotification *)notifition
{
    [self inputMessage:notifition.object url:nil type:0];
    [self replayWithText:notifition.object];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  键盘通知方法
 *
 *  @param note 键盘通知的参数
 */
-(void)click:(NSNotification *)note
{
   
    self.view.window.backgroundColor = self.tableview.backgroundColor;
    
    // 0.取出键盘动画的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    // 1.取得键盘最后的frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.计算控制器的view需要平移的距离
    CGFloat transformY = keyboardFrame.origin.y - self.view.frame.size.height;
    
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];

}



#pragma mark 数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageFrames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.创建cell
    MessageCell *cell = [MessageCell cellWithTableView:tableView];
    
    //2.传递数据
    cell.messageFrame = self.messageFrames[indexPath.row];

    
    //3.返回cell
    return cell;
}


//代理方法，退出键盘
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

//cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageFrame *mf = self.messageFrames[indexPath.row];
    return mf.cellHeight;
}






#pragma mark 文本框代理
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    //自己发送消息
    [self inputMessage:textField.text url:nil type:0];

    //对方回复的

    [self replayWithText:textField.text];

    self.inputView.text = nil;
    
    return YES;
}



//对方回复的
-(void)replayWithText:(NSString *)text
{

    //1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //2.封装请求参数
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"key"] = @"b6645d5b8c0a07b5b0a468ac881ef6a8";
    dic[@"info"] = text;
    
    
    //3.发送请求。
    [mgr GET:@"http://www.tuling123.com/openapi/api" parameters:dic
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         NSLog(@"----------- %@",responseObject);
         
        NSString *ns = responseObject[@"text"];
         NSString *nss = responseObject[@"url"];
         NSDictionary *dic = responseObject[@"list"];
         NSLog(@"%@,%@---%@",ns,nss,dic);

       [self inputMessage:ns url:nss type:1];
       
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
     }];
   
    


}


-(void)inputMessage:(NSString *)text url:(NSString *)url type:(MessageType)type
{
    if (url) {

      //  NSString *str = [text stringByAppendingString:url];
        Message *msg = [[Message alloc]init];
      //  msg.text = text;
        msg.type = type;
        msg.url = url;
        
        MessageFrame *mf = [[MessageFrame alloc]init];
        mf.message = msg;
        [self.messageFrames addObject:mf];

        //把数据存入数据库
        [MessageCache addMessage:msg.url type:type];
        
    }else{
        Message *msg = [[Message alloc]init];
        msg.text = text;
        msg.type = type;
        
        MessageFrame *mf = [[MessageFrame alloc]init];
        mf.message = msg;
        [self.messageFrames addObject:mf];

        [MessageCache addMessage:msg.text type:type];
    
    }

    
    [self.tableview reloadData];
    
    // 4.自动滚动表格到最后一行
    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableview scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)configUIAppearce
{
    self.view.backgroundColor = [UIColor redColor];
}

//#pragma mark 语音
//
//- (IBAction)soundvoice {
//    
//    _iflyrReco = [[IFlyRecognizerView alloc]initWithCenter:self.view.center];
//    _iflyrReco.delegate = self;
//    [_iflyrReco setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
//   // [_iflyrReco setParameter:@"asrview.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
//    //指定返回数据格式
//    [_iflyrReco setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
//    [_iflyrReco start];
//    
//}
//
///**
// *  识别结果返回代理
// *
// *  @param resultArray 识别结果
// *  @param isLast      最后一次结果
// */
//-(void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
//{
//    NSMutableString *result = [[NSMutableString alloc] init];
//    NSDictionary *dic = [resultArray objectAtIndex:0];
//    
//    for (NSString *key in dic) {
//        [result appendFormat:@"%@",key];
//    }
//    
//
//    [self replayWithText:result];
//    [self inputMessage:result url:nil type:MessageTypeMe];
//}
///**
// *  识别会话错误返回代理
// *
// *  @param error 错误码
// */
//-(void)onError:(IFlySpeechError *)error
//{
//    NSLog(@"error ------------ %@",error);
//}
//

@end
