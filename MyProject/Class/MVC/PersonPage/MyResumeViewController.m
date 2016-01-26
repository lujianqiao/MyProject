//
//  MyResumeViewController.m
//  MyProject
//
//  Created by 千锋 on 16/1/20.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "MyResumeViewController.h"
#import <ActionSheetPicker-3.0/ActionSheetPicker.h>

@interface MyResumeViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UIButton *sexButton;
@property (weak, nonatomic) IBOutlet UIButton *birthdayButton;

@property (weak, nonatomic) IBOutlet UIButton *workType;
@property (weak, nonatomic) IBOutlet UIButton *place;
@property (weak, nonatomic) IBOutlet UIButton *workPlace;

@property (weak, nonatomic) IBOutlet UIButton *workTime;

@property(nonatomic,strong)UIDatePicker *  datePicker ;
@property(nonatomic,strong)  UIView * buttonView;
@property(nonatomic,copy)NSString * birthday;
@property(nonatomic,strong)UIView * backgroundView;

@property(nonatomic,strong)NSArray * worktypeArr;
@property(nonatomic,strong)NSArray * placePicker;
@property(nonatomic,strong)NSArray * workTimePicker;

@end

@implementation MyResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//懒加载
-(NSArray *)worktypeArr
{
    if (_worktypeArr == nil) {
        _worktypeArr = @[@"普工/技工",@"汽车行业",@"司机",@"建筑/施工",@"餐饮/酒店",@"零售/百货",@"美容/美发/按摩",@"运动/健身",@"电商/平台",@"家政/安保",@"休闲/娱乐",@"销售",@"客服",@"人事/行政",@"会计/出纳",@"贸易/物流",@"保险/房产中介",@"物业/商业",@"兼职/实习",@"其他"];
    }
    return _worktypeArr;
}
-(NSArray *)placePicker
{
    if (_placePicker == nil) {
        _placePicker = @[@"直辖市",@"河北省",@"山西省",@"内蒙古",@"辽宁省",@"吉林省",@"黑龙江省",@"江苏省",@"浙江省",@"安徽省",@"福建省",@"江西省",@"山东省",@"河南省",@"湖北省",@"湖南省",@"广东省",@"广西壮族省",@"海南省",@"四川省",@"贵州省",@"云南省",@"西藏自治区",@"陕西省",@"甘肃省",@"宁夏回族自治区",@"新疆维吾尔自治区"];
    }
    return _placePicker;
}

-(NSArray *)workTimePicker
{
    if (_workTimePicker ==nil) {
        _workTimePicker = @[@"2000以下",@"2001-3000",@"3001-5000",@"5001-8000",@"8001-10000",@"10001-15000",@"15001-20000",@"20000以上"];
    }
    return _workTimePicker;
}
//选择性别
- (IBAction)chooseSex:(UIButton *)sender {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"请选择你的性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * man = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       self.sexButton.titleLabel.text = @"男";
    }];
    UIAlertAction * woman = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.sexButton.titleLabel.text = @"女";
    }];
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:man];
    [alert addAction:woman];
    [alert addAction:cancle];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}
//选择生日
- (IBAction)chooseBirthday:(id)sender {
    self.backgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.backgroundView];
    self.backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
    [UIView animateWithDuration:1 animations:^{
        
    _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(50, 100, 0, 0)];
    [self.backgroundView addSubview:_datePicker];
    _datePicker.backgroundColor = [UIColor whiteColor];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    [_datePicker addTarget:self action:@selector(datechanged:) forControlEvents:UIControlEventValueChanged];
        
        _buttonView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_datePicker.frame), CGRectGetMaxY(_datePicker.frame), CGRectGetWidth(_datePicker.frame), 40)];
        [self.backgroundView addSubview:_buttonView];
        _buttonView.backgroundColor = [UIColor whiteColor];
        UIButton * canleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
        [_buttonView addSubview:canleButton];
        canleButton.layer.cornerRadius = 15;
        
        canleButton.backgroundColor = [UIColor orangeColor];
        [canleButton setTitle:@"取消" forState:UIControlStateNormal];

        [canleButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [canleButton addTarget:self action:@selector(canle) forControlEvents:UIControlEventTouchDown];
        UIButton * doneButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(_buttonView.frame)-70, 0, 70, 30)];
        [_buttonView addSubview:doneButton];
        doneButton.backgroundColor = [UIColor orangeColor];
        doneButton.layer.cornerRadius = 15;
        [doneButton setTitle:@"确定" forState:UIControlStateNormal];

        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [doneButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchDown];
    
    }];
    
}
-(void)canle
{
    [self.datePicker removeFromSuperview];
    [self.buttonView removeFromSuperview];
    [self.backgroundView removeFromSuperview];
    
}

-(void)done
{
    [self.birthdayButton setTitle:self.birthday forState:UIControlStateNormal];
    [self.datePicker removeFromSuperview];
    [self.buttonView removeFromSuperview];
    [self.backgroundView removeFromSuperview];
}
//时间选择回调
-(void)datechanged:(id)sender
{
    UIDatePicker * control = (UIDatePicker *)sender;
    NSDate * date =control.date;
    
    NSDateFormatter * dateFormatter =[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * dateStr = [dateFormatter stringFromDate:date];
    
    NSLog(@"date-------%@",dateStr);
    self.birthday = dateStr;
}

//选择工种
- (IBAction)chooseWorkType:(id)sender {
 
    [ActionSheetStringPicker showPickerWithTitle:@"选择你的工种种类"
                                            rows:self.worktypeArr
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           [self.workType setTitle:selectedValue forState:UIControlStateNormal];
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, (long)selectedIndex, selectedValue);
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}
//选择工作地点
- (IBAction)chooseWorkPlase:(id)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"选择你的所在地"
                                            rows:self.placePicker
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           [self.place setTitle:selectedValue forState:UIControlStateNormal];
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, (long)selectedIndex, selectedValue);
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
    
    
}
//选择期望工作地点
- (IBAction)chooseExpectPlase:(id)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"选择你的期望工作地"
                                            rows:self.placePicker
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           [self.workPlace setTitle:selectedValue forState:UIControlStateNormal];
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, (long)selectedIndex, selectedValue);
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
    
}
//选择工作经验
- (IBAction)chooseWorkExperience:(id)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"选择你的工作年限"
                                            rows:self.workTimePicker
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           [self.workTime setTitle:selectedValue forState:UIControlStateNormal];
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, (long)selectedIndex, selectedValue);
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}
//添加工作经验
- (IBAction)addWorkExperience:(id)sender {
}
//添加学习经验
- (IBAction)addLearnExperience:(id)sender {
}



@end
