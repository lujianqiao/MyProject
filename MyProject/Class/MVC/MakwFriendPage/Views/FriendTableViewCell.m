//
//  FriendTableViewCell.m
//  MyProject
//
//  Created by 千锋 on 16/1/13.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "FriendTableViewCell.h"
#import "UIImageView+WebCache.h"


@interface FriendTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userIconImage;
@property (weak, nonatomic) IBOutlet UIImageView *userLevelImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;


@property (weak, nonatomic) IBOutlet UIImageView *hadLookImage;
@property (weak, nonatomic) IBOutlet UILabel *hadLookLabel;
@property (weak, nonatomic) IBOutlet UIImageView *commentImage;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *loveImage;
@property (weak, nonatomic) IBOutlet UILabel *loveLabel;



@end

@implementation FriendTableViewCell



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setFrame:(CGRect)frame
{
    frame.size.height-=5;
    [super setFrame:frame];
}

-(void)setModel:(FriendPageModel *)model
{
    //赋值
    [self.userIconImage sd_setImageWithURL:[NSURL URLWithString:model.head]];
    self.userName.text = model.creater;
    self.title.text = model.title;
    self.content.text = model.content;
    self.time.text = model.create_time;
    [self.detailImage sd_setImageWithURL:[NSURL URLWithString:model.previewUrl]];
    self.hadLookLabel.text = [NSString stringWithFormat:@"%d",model.downCnt];
    self.commentLabel.text = [NSString stringWithFormat:@"%d",model.replyCnt];
    self.loveLabel.text = [NSString stringWithFormat:@"%d",model.upCnt];
    self.userLevelImage.image = [UIImage imageNamed:@"friend_grade_fifteen"];
    
    
    //设置属性
    self.userIconImage.layer.cornerRadius = CGRectGetWidth(self.userIconImage.frame)/2;
}

@end
