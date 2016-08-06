//
//  TypeThreeViewController.m
//  众商智推
//
//  Created by 杨 on 16/5/27.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "TypeThreeViewController.h"
#import "PhotoLoadMethod.h"

@interface TypeThreeViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


//点击上传图片
@property (nonatomic,strong) UIButton * photoLibraryBtn;

/**
 *保存按钮
 */
@property (strong, nonatomic) UIButton *saveMessageBtn;

@property (strong,nonatomic)UIButton * tmpBtn;

@end

@implementation TypeThreeViewController
{
    UIScrollView * scrollView;
    PhotoLoadMethod * ph;
    UIButton *qrCodeBtn;
    UIButton *uploadQrCodeBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:ZSColor(244, 244, 244)];
    [self createHeadUI];
    [self createContentControls];
    
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
    titleLabel.text = @"广告类型3";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
}
//退出此控制器返回到上级的控制器
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)createContentControls
{
    //背景scrollView
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    [scrollView setBackgroundColor:ZSColor(244, 244, 244)];
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    UILabel *qrCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 40)];
    qrCodeLabel.text = @"二维码";
    qrCodeLabel.font = [UIFont boldSystemFontOfSize:20];
    [scrollView addSubview:qrCodeLabel];
    
    UIView *qrCodeView = [[UIView alloc] initWithFrame:CGRectMake(10, 50, ScreenWidth-20, 85)];
    qrCodeView.backgroundColor = [UIColor whiteColor];
    qrCodeView.layer.cornerRadius = 5;
    qrCodeView.layer.masksToBounds = YES;
    [scrollView addSubview:qrCodeView];
    
    qrCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    qrCodeBtn.frame = CGRectMake(15, 12, 60, 60);
    qrCodeBtn.backgroundColor = [UIColor grayColor];
    [qrCodeView addSubview:qrCodeBtn];
    
    uploadQrCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    uploadQrCodeBtn.frame = CGRectMake(ScreenWidth - 280, 20, 260, 50);
//    uploadQrCodeBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:211/255.0 blue:100/255.0 alpha:1];
    [uploadQrCodeBtn setTitle:@"上传二维码(420px*420px)" forState:UIControlStateNormal];
    [uploadQrCodeBtn setImage:[UIImage imageNamed:@"rightExtension.png"] forState:UIControlStateNormal];
    uploadQrCodeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 240, 0, 0);
    uploadQrCodeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25);
    [uploadQrCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [uploadQrCodeBtn addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
    [qrCodeView addSubview:uploadQrCodeBtn];
    
    UILabel *adLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 145, 100, 40)];
    adLabel.text = @"广告语";
    adLabel.font = [UIFont boldSystemFontOfSize:20];
    [scrollView addSubview:adLabel];
    
    self.adTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 195, ScreenWidth-20, 60)];
    self.adTextField.placeholder = @"请添加您的广告语(限30字)...";
    self.adTextField.delegate = self;
    self.adTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:self.adTextField];
    
    UILabel *linkLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 260, 100, 40)];
    linkLabel.text = @"广告链接";
    linkLabel.font = [UIFont boldSystemFontOfSize:20];
    [scrollView addSubview:linkLabel];
    
    self.linkTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 305, ScreenWidth-20, 60)];
    self.linkTextField.placeholder = @"请输入您的广告链接，网址请加http://";
    self.linkTextField.delegate = self;
    self.linkTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:self.linkTextField];
    
    UILabel *backgroundLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 375, 100, 40)];
    backgroundLabel.text = @"广告背景";
    backgroundLabel.font = [UIFont boldSystemFontOfSize:20];
    [scrollView addSubview:backgroundLabel];
    
    //选中的按钮
    self.selectedImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vv"]];
    self.selectedImg.size = CGSizeMake(20,20);
    self.selectedImg.center = CGPointMake(CGRectGetMaxX(self.background1.frame),CGRectGetMinY(self.background1.frame));
    self.imgData = UIImagePNGRepresentation([UIImage imageNamed:@"11.png"]);
    
    //背景1
    self.background1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.background1.frame = CGRectMake(10, 425, ScreenWidth-20, 90);
    self.background1.layer.cornerRadius = 5;
    self.background1.layer.masksToBounds = YES;
    self.background1.tag = 11;
    [self.background1 setTitle:@"广告语" forState:UIControlStateNormal];
    [self.background1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.background1 setBackgroundImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
    [self.background1 setBackgroundImage:[UIImage imageNamed:@"adBackgroundSelect1.png"] forState:UIControlStateSelected];
    [self.background1 addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.background1];
    
    //背景2
    self.background2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.background2.frame = CGRectMake(10, 525, ScreenWidth-20, 90);
    self.background2.layer.cornerRadius = 5;
    self.background2.layer.masksToBounds = YES;
    self.background2.tag = 22;
    [self.background2 setTitle:@"广告语" forState:UIControlStateNormal];
    [self.background2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.background2 setBackgroundImage:[UIImage imageNamed:@"22.png"] forState:UIControlStateNormal];
    [self.background2 setBackgroundImage:[UIImage imageNamed:@"adBackgroundSelect2.png"] forState:UIControlStateSelected];
    [self.background2 addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.background2];
    //背景3
    self.background3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.background3.frame = CGRectMake(10, 625, ScreenWidth-20, 90);
    self.background3.layer.cornerRadius = 5;
    self.background3.layer.masksToBounds = YES;
    self.background3.tag = 33;
    [self.background3 setTitle:@"广告语" forState:UIControlStateNormal];
    [self.background3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.background3 setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
    [self.background3 setBackgroundImage:[UIImage imageNamed:@"adBackgroundSelect3.png"] forState:UIControlStateSelected];
    [self.background3 addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.background3];

    
    self.hiddenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hiddenBtn.frame = CGRectMake(10, 725, ScreenWidth-20, 90);
    self.hiddenBtn.layer.cornerRadius = 5;
    self.hiddenBtn.layer.masksToBounds = YES;
    [scrollView addSubview:self.hiddenBtn];
    
    
    self.photoLibraryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.photoLibraryBtn.frame = CGRectMake(10, 725, ScreenWidth-20, 90);
    self.photoLibraryBtn.backgroundColor = [UIColor grayColor];
    self.photoLibraryBtn.layer.cornerRadius = 5;
    self.photoLibraryBtn.layer.masksToBounds = YES;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"+点击上传广告图片（600px*160px)"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [self.photoLibraryBtn setAttributedTitle:str forState:UIControlStateNormal];
    [self.photoLibraryBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.photoLibraryBtn addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.photoLibraryBtn];

    
    self.saveMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveMessageBtn.frame = CGRectMake(10, 825, ScreenWidth-20, 50);
    self.saveMessageBtn.backgroundColor = ZSColor(0, 211, 100);
    [self.saveMessageBtn setTitle:@"保存" forState:UIControlStateNormal];
    self.saveMessageBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.saveMessageBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.saveMessageBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [self.saveMessageBtn addTarget:self action:@selector(saveMessageBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    self.saveMessageBtn.layer.cornerRadius = 5;
    self.saveMessageBtn.layer.masksToBounds = YES;
    [scrollView addSubview:self.saveMessageBtn];
    scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.saveMessageBtn.frame)+20);
}

-(void)buttonSelected:(UIButton*)sender{
    
    [self.selectedImg removeFromSuperview];
    self.selectedImg.center = CGPointMake(CGRectGetMaxX(sender.frame), CGRectGetMinY(sender.frame));
    
    UIImage * img = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",(long)sender.tag]];
    self.imgData = UIImagePNGRepresentation(img);
}
//代理方法从图库或相机选择图片
-(void)selectImage:(UIButton*)btn{
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    ph = [[PhotoLoadMethod alloc] init];
    [ph loadImageFromLibrayWithController:self alertController:alertView Block:^(UIImage *image) {
        if (btn == uploadQrCodeBtn) {
            [qrCodeBtn setBackgroundImage:image forState:UIControlStateNormal];
            self.qrCodeData = UIImagePNGRepresentation(image);
        }else{
            self.imgData = UIImageJPEGRepresentation(image, 0.5);
            self.selectedImg.center = CGPointMake(CGRectGetMaxX(self.hiddenBtn.frame), CGRectGetMinY(self.hiddenBtn.frame));
            [self.hiddenBtn setBackgroundImage:image forState:UIControlStateNormal];
            CGRect frame = self.photoLibraryBtn.frame;
            frame.origin.y = frame.origin.y +100;
            self.photoLibraryBtn.frame = frame;
            CGRect saveFrame = self.saveMessageBtn.frame;
            saveFrame.origin.y = saveFrame.origin.y +100;
            self.saveMessageBtn.frame = saveFrame;
            
            CGSize contentsize = scrollView.contentSize;
            contentsize.height = CGRectGetMaxY(self.saveMessageBtn.frame) + 20;
            scrollView.contentSize = contentsize;
        }
    }];
}

- (void)saveMessageBtnMethod
{
    ZSLog(@"保存按钮被点击!!");
    
    NSMutableDictionary * infoDic = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithFile:kPath];//将沙盒路径下的归档对象解档出来
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:self.adTextField.text forKey:@"adTitle"];
    [dic setValue:self.linkTextField.text forKey:@"url"];
    [dic setValue:self.imgData forKey:@"bgImg"];
    [dic setValue:self.qrCodeData forKey:@"focusBtnImg"];
    [dic setValue:[NSString stringWithFormat:@"%ld",self.orderNum] forKey:@"orderNum"];
    if (infoDic[@"ad3"] == nil) {
        NSMutableArray * arr = [NSMutableArray array];
        //非常重要
        //        [dic setValue:@"id" forKey:@"id"];
        [arr addObject:dic];
        [infoDic setValue:arr forKey:@"ad3"];
        [NSKeyedArchiver archiveRootObject:infoDic toFile:kPath];
    }else{
        //            NSMutableArray * tempArr = [NSMutableArray arrayWithObject:infoDic[@"ad2"]];
        [infoDic[@"ad3"] addObject:dic];
        //保存用户添加的数据（如果数据存在，则覆盖setObject: forkey:，否则添加addObject）
        //        for (NSDictionary * dic in tempArr) {
        //            if ([dic[@"id"] isEqualToString:self.ID])//@"从服务器请求回来的id添加到广告条中作为一个value，编辑跳转到这个页面时把id当做参数传过来，并找到id对应的dictionary，重新保存数据，然后写入plist文件，若是添加跳转到这个页面时，则else{addObject到tempArr数组中，并写入plist文件}，重点：无论怎样写入plist文件之前要先将数据进行post到后台成功返回再存储"])
        //            {
        //                [dic setValue:self.adTextField.text forKey:@"adTitle"];
        //                [dic setValue:self.linkTextField.text forKey:@"url"];
        //                [dic setValue:self.imgData forKey:@"bgImg"];
        //            }
        //        }
        [infoDic setValue:infoDic[@"ad3"] forKey:@"ad3"];
    }
    //把刚才写的数组存到沙盒当中去
    if ([NSKeyedArchiver archiveRootObject:infoDic toFile:kPath]) {
        ZSLog(@"信息保存成功");
        //        [self changeEnable];
        [self goBack];
    }else{
        ZSLog(@"信息保存失败");
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    //上下文动画内，改变当前视图坐标
//    [UIView beginAnimations:@"text" context:nil];
//    [UIView setAnimationDuration:0.3];
//    
//    CGRect rect = self.view.frame;
//    rect.origin.y = -210;
//    self.view.frame = rect;
//    
//    [UIView commitAnimations];
//    return YES;
//}
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    [UIView beginAnimations:@"text" context:nil];
//    [UIView setAnimationDuration:0.3];
//    
//    CGRect rect = self.view.frame;
//    rect.origin.y = 0;
//    self.view.frame = rect;
//    
//    [UIView commitAnimations];
//    return YES;
//    
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
