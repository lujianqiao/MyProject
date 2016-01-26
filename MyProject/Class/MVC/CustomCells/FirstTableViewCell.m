//
//  FirstTableViewCell.m
//  MyProject
//
//  Created by 千锋 on 16/1/11.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell
{
    UILabel * _firstLabel;//工种
    UIButton * _firstButton;//工种
    UILabel * _secondLabel;//地点
    UIButton * _secondButton;//地点
    UILabel * _thirdLabel;//薪资
    UIButton * _thirdButton;//薪资
}
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

//刷新视图
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (!_firstLabel) {
        _firstLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_firstLabel];
        _firstLabel.text=@"工种";
        _firstLabel.font = [UIFont systemFontOfSize:13];
        _firstLabel.textAlignment  = NSTextAlignmentCenter;
    }
    if (!_firstButton) {
        _firstButton = [[UIButton alloc]init];
        [self.contentView addSubview:_firstButton];
        [_firstButton addTarget:self action:@selector(firstButtonClicked:) forControlEvents:UIControlEventTouchDown];
        [_firstButton setTitle:@"请选择..." forState:UIControlStateNormal];
        _firstButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _firstButton.layer.cornerRadius = 5;
        _firstButton.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change1Name:) name:@"type" object:nil];
        
            }
    if (!_secondLabel) {
        _secondLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_secondLabel];
        _secondLabel.text = @"地点";
        _secondLabel.font = [UIFont systemFontOfSize:13];
        _secondLabel.textAlignment = NSTextAlignmentCenter;
    }
    if (!_secondButton) {
        _secondButton  =[[UIButton alloc]init];
        [self.contentView addSubview:_secondButton];
        [_secondButton addTarget:self action:@selector(secondButtonClicked:) forControlEvents:UIControlEventTouchDown];
        [_secondButton setTitle:@"请选择..." forState:UIControlStateNormal];
        _secondButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _secondButton.layer.cornerRadius = 5;
        _secondButton.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change2Name:) name:@"place" object:nil];
    }
    if (!_thirdLabel) {
        _thirdLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_thirdLabel];
        _thirdLabel.text = @"薪资";
        _thirdLabel.font = [UIFont systemFontOfSize:13];
        _thirdLabel.textAlignment = NSTextAlignmentCenter;
    }
    if (!_thirdButton) {
        _thirdButton = [[UIButton alloc]init];
        [self.contentView addSubview:_thirdButton];
        [_thirdButton addTarget:self action:@selector(thirdButtonClicked:) forControlEvents:UIControlEventTouchDown];
        [_thirdButton setTitle:@"请选择..." forState:UIControlStateNormal];
        _thirdButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _thirdButton.layer.cornerRadius = 5;
        _thirdButton.backgroundColor  = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change3Name:) name:@"money" object:nil];
    }
    
    CGSize size = self.frame.size;
    _firstLabel.frame = CGRectMake(0, 0, size.width/9, size.height);
    _firstButton.frame = CGRectMake(size.width/9, 0, size.width/9*2, size.height);
    _secondLabel.frame = CGRectMake(size.width/9*3, 0, size.width/9, size.height);
    _secondButton.frame = CGRectMake(size.width/9*4, 0, size.width/9*2, size.height);
    _thirdLabel.frame = CGRectMake(size.width/9*6, 0, size.width/9, size.height);
    _thirdButton.frame = CGRectMake(size.width/9*7, 0, size.width/9*2, size.height);
    
}

//接收到监听后的响应
-(void)change1Name:(NSNotification *)noti
{
    NSLog(@"----------------%@",noti.object);
    _firstButton.titleLabel.text = noti.object;
}

-(void)change2Name:(NSNotification *)noti
{
    _secondButton.titleLabel.text = noti.object;
}

-(void)change3Name:(NSNotification *)noti
{
    _thirdButton.titleLabel.text = noti.object;
}

-(void)firstButtonClicked:(UIButton *)sender
{
  
    [[NSNotificationCenter defaultCenter]postNotificationName:@"workcategory" object:nil userInfo:nil];
}

-(void)secondButtonClicked:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"workplace" object:nil];
}
-(void)thirdButtonClicked:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"workwage" object:nil];

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end


















