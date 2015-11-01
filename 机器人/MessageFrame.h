//
//  MessageFrame.h
//  机器人
//
//  Created by gyh on 15/5/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Message;
@interface MessageFrame : NSObject

/**
 *  头像的frame
 */
@property (nonatomic, assign, readonly) CGRect iconF;
/**
 *  时间的frame
 */
@property (nonatomic, assign, readonly) CGRect timeF;
/**
 *  正文的frame
 */
@property (nonatomic, assign, readonly) CGRect textF;
/**
 *  cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

/**
 *  数据模型
 */
@property (nonatomic, strong) Message *message;


@end
