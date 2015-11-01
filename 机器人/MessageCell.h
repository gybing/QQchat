//
//  MessageCell.h
//  机器人
//
//  Created by gyh on 15/5/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageFrame;
@interface MessageCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) MessageFrame *messageFrame;

@end
