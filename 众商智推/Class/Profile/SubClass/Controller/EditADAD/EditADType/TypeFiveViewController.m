//
//  TypeFiveViewController.m
//  众商智推
//
//  Created by 杨 on 16/7/12.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "TypeFiveViewController.h"
#import "PhotoLoadMethod.h"

@interface TypeFiveViewController ()<UITextFieldDelegate,UIScrollViewDelegate>

/**
 *上传广告图片按钮
 */
@property (strong, nonatomic) UIButton *upLoadBtn;
@property (nonatomic,strong) UIButton * hiddenBtn;
@property (nonatomic,strong) UIImageView * selectedImg;
/**
 *保存按钮
 */
@property (strong, nonatomic) UIButton *saveMessageBtn;


@end

@implementation TypeFiveViewController
{
    UIScrollView *scrollView;
    PhotoLoadMethod * ph;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:ZSColor(244, 244, 244)];
    [self createHeadUI];
    [self createContentControls];
    self.imgData = UIImagePNGRepresentation([UIImage imageNamed:@"11"]);
    
}
#pragma mark - 创建顶部View
- (void)createHeadUI
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    headView.backgroundColor = ZSColor(19, 143, 253);
    [self.view addSubview:headView];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 25, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    
    //标题按钮
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-60, 25, 120, 40)];
    titleLabel.text = @"广告类型5";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
    
    
    
    
}
//退出此控制器返回到上级的控制器
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -
#pragma mark - 加载内容控件
- (void)createContentControls
{
    //背景scrollView
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    [scrollView setBackgroundColor:ZSColor(244, 244, 244)];
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(0, ScreenHeight-64);
    [self.view addSubview:scrollView];
    
    UILabel *adLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 40)];
    adLabel.text = @"广告语";
    adLabel.font = [UIFont boldSystemFontOfSize:20];
    [scrollView addSubview:adLabel];
    
    self.adTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 55, ScreenWidth-20, 60)];
    //获取沙盒中存取的数据信息
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"adType.txt"];//当前应用的沙盒路径
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    self.adTextField.text = [array objectAtIndex:0];
    self.adTextField.placeholder = @"请添加您的广告语(限30字)...";
    self.adTextField.delegate = self;
    self.adTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:self.adTextField];
    
    UILabel *linkLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 100, 40)];
    linkLabel.text = @"广告链接";
    linkLabel.font = [UIFont boldSystemFontOfSize:20];
    [scrollView addSubview:linkLabel];
    
    self.linkTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 165, ScreenWidth-20, 60)];
    self.linkTextField.placeholder = @"请输入您的广告链接，网址请加http://";
    self.linkTextField.delegate = self;
    self.linkTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:self.linkTextField];
    
    UILabel *backgroundLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 235, 100, 40)];
    backgroundLabel.text = @"广告背景";
    backgroundLabel.font = [UIFont boldSystemFontOfSize:20];
    [scrollView addSubview:backgroundLabel];
    
    self.hiddenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hiddenBtn.frame = CGRectMake(10, 285, ScreenWidth-20, 90);
    self.hiddenBtn.layer.cornerRadius = 5;
    self.hiddenBtn.layer.masksToBounds = YES;
    [scrollView addSubview:self.hiddenBtn];
    
    
    //背景1
    self.upLoadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.upLoadBtn.frame = CGRectMake(10, 285, ScreenWidth-20, 90);
    self.upLoadBtn.layer.cornerRadius = 5;
    self.upLoadBtn.layer.masksToBounds = YES;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"+点击上传广告图片（600px*160px)"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [self.upLoadBtn setAttributedTitle:str forState:UIControlStateNormal];
    [self.upLoadBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.upLoadBtn setTitle:@"+点击上传广告图片（600px*160px）" forState:UIControlStateNormal];
    [self.upLoadBtn setBackgroundColor:[UIColor grayColor]];
    [self.upLoadBtn addTarget:self action:@selector(selectImage) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.upLoadBtn];
//    保存按钮
    self.saveMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //        _saveBtn.frame = CGRectMake(10, 500, ScreenWidth-20, 50);
    self.saveMessageBtn.frame = CGRectMake(10, 400, ScreenWidth-20, 50);
    self.saveMessageBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:211/255.0 blue:100/255.0 alpha:1];
    [self.saveMessageBtn setTitle:@"保存" forState:UIControlStateNormal];
    self.saveMessageBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.saveMessageBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.saveMessageBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [self.saveMessageBtn addTarget:self action:@selector(saveMessageBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    self.saveMessageBtn.layer.cornerRadius = 5;
    self.saveMessageBtn.layer.masksToBounds = YES;
    [scrollView addSubview:self.saveMessageBtn];
    
}

-(void)selectImage{
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    ph = [[PhotoLoadMethod alloc] init];
    [ph loadImageFromLibrayWithController:self alertController:alertView Block:^(UIImage *image) {
        self.imgData = UIImagePNGRepresentation(image);
        [self.hiddenBtn setBackgroundImage:image forState:UIControlStateNormal];
        self.selectedImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vv"]];
        self.selectedImg.size = CGSizeMake(20,20);
        self.selectedImg.center = CGPointMake(CGRectGetMaxX(self.hiddenBtn.frame), CGRectGetMinY(self.hiddenBtn.frame));
        [scrollView addSubview:self.selectedImg];
        
        self.upLoadBtn.frame = CGRectMake(10, 385, ScreenWidth-20, 90);
        
        self.saveMessageBtn.frame = CGRectMake(10, 500, ScreenWidth-20, 50);
    }];
}
- (void)saveMessageBtnMethod
{
    ZSLog(@"保存按钮被点击!!");
    
    NSMutableDictionary * infoDic = [NSMutableDictionary dictionaryWithCapacity:0];
    infoDic = (NSMutableDictionary*)[NSKeyedUnarchiver unarchiveObjectWithFile:kPath];//将沙盒路径下的归档对象解档出来
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:self.adTextField.text forKey:@"title"];
    [dic setValue:self.linkTextField.text forKey:@"adurl"];
    [dic setValue:@"5" forKey:@"type"];
    NSDictionary * para = [NSDictionary dictionaryWithDictionary:dic];
    NSMutableArray * arr = [NSMutableArray array];
    
    //存在ad1，先去查找ad1里面的所有广告id，有的话说明是要编辑，没有自然就是添加喽
    if (self.adId != nil) {
        for (__strong NSMutableDictionary * tempDic in infoDic[@"ad1"]) {
            NSString * adIdStr = tempDic[@"adId"];
            if ([self.adId isEqualToString:adIdStr]) {
                //如果当前类中adId有值且和本地储存的一个广告中的adId相等，说明用户在修改广告条
                tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                [HTTPToolsPost EditPostRequestWithUrl:EditUrl parameters:para imageData:self.imgData QRCode:nil completion:^{
                    [tempDic setValue:self.imgData forKey:@"image"];
                    [arr addObject:tempDic];
                    [infoDic setValue:arr forKey:@"ad1"];
                    if ([NSKeyedArchiver archiveRootObject:infoDic toFile:kPath]) {
                        [self goBack];
                    }
                }];
            }
        }
    }else{
        [HTTPToolsPost StoragePostRequestWithUrl:StorageUrl parameters:para imageData:self.imgData QRCode:nil success:^(NSString *ADId) {
            [dic setValue:ADId forKey:@"adId"];
            [dic setValue:self.imgData forKey:@"image"];
            [arr addObject:dic];
            [infoDic setValue:arr forKey:@"ad1"];
            if ([NSKeyedArchiver archiveRootObject:infoDic toFile:kPath]) {
                [self goBack];
            }
        } fail:^{
            //
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //上下文动画内，改变当前视图坐标
    [UIView beginAnimations:@"text" context:nil];
    [UIView setAnimationDuration:0.3];
    
    CGRect rect = self.view.frame;
    rect.origin.y = -50;
    self.view.frame = rect;
    
    [UIView commitAnimations];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:@"text" context:nil];
    [UIView setAnimationDuration:0.3];
    
    CGRect rect = self.view.frame;
    rect.origin.y = 0;
    self.view.frame = rect;
    
    [UIView commitAnimations];
    return YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
