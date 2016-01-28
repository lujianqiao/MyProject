//
//  PublicNoticeTableViewCell.h
//  MyProject
//
//  Created by 千锋 on 16/1/18.
//  Copyright © 2016年 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicNoticeModel.h"

@interface PublicNoticeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property(nonatomic,strong)PublicNoticeModel * model;
@end
