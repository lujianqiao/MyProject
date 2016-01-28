//
//  PublicNoticeTableViewCell.m
//  MyProject
//
//  Created by 千锋 on 16/1/18.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "PublicNoticeTableViewCell.h"

@implementation PublicNoticeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//}
-(void)setFrame:(CGRect)frame
{
    frame.size.height-=5;
    [super setFrame:frame];
}

-(void)setModel:(PublicNoticeModel *)model
{
    self.detailLabel.text = model.content;
    self.timeLabel.text = [NSString stringWithFormat:@"%ld",(long)model.create_time];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
