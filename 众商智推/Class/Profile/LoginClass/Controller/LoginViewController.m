//
//  LoginViewController.m
//  有道词典
//
//  Created by ma c on 16/3/11.
//  Copyright © 2016年 梁玉梅. All rights reserved.
//

#import "LoginViewController.h"
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"
#import "UserInfoModel.h"
#import "UIImageView+WebCache.h"
#import "ProfileViewController.h"

#define USERINFOPATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"userInfo.txt"]

@interface LoginViewController ()<UMSocialUIDelegate>

//logo和名称
@property (strong, nonatomic) UIImageView *logoImage;
@property (strong, nonatomic) UILabel *nameLabel;

//线
@property (nonatomic, strong) UIView *lineView;
//messageLabel
@property (nonatomic, strong) UILabel *messageLabel;
//新浪
@property (nonatomic, strong) UIButton *sinaBtn;
//腾讯
@property (nonatomic, strong) UIButton *qqBtn;
//微信
@property (strong, nonatomic) UIButton *weiXinBtn;
//处理点击登录事件后的block对象
@property(nonatomic, copy) UMSocialSnsPlatformLoginHandler loginClickHandler;

@end

@implementation LoginViewController

+ (LoginViewController*)share
{
    static LoginViewController *tempcontroller =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tempcontroller = [[LoginViewController alloc] init];
//        tempcontroller.view.frame = [UIScreen mainScreen].bounds;

    });
    return tempcontroller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    
    [self createUI];
    [self.view addSubview:self.logoImage];
    [self.view addSubview:self.nameLabel];
//    [self.view addSubview:self.lineView];
    [self.view addSubview:self.messageLabel];
    
    [self.view addSubview:self.sinaBtn];
    [self.view addSubview:self.qqBtn];
    [self.view addSubview:self.weiXinBtn];
    
//    [self addUserNameAndUserIcon];
    
}
#pragma mark - 创建顶部View
- (void)createUI
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
//    headView.backgroundColor = [UIColor colorWithRed:19/255.0 green:143/255.0 blue:253/255.0 alpha:1];
    [self.view addSubview:headView];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 25, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn setTitleColor:ZSColor(19, 143, 253) forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    
//    //横线
//    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 3)];
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = (CGRect){CGPointZero,CGSizeMake(ScreenWidth, 3)};
//    //颜色分配
//    gradient.colors = [NSArray arrayWithObjects:
//                       (id)[UIColor blueColor].CGColor,
//                       (id)[UIColor purpleColor].CGColor,
//                       (id)[UIColor redColor].CGColor
//                       ,nil];
//    // 颜色分割线
//    gradient.locations = @[@(0.25),@(0.5),@(0.75)];
//    // 起始点
//    gradient.startPoint = CGPointMake(0, 0);
//    // 结束点
//    gradient.endPoint = CGPointMake(1, 0);
//    [lineLabel.layer insertSublayer:gradient atIndex:0];
//    [self.view addSubview:lineLabel];
}
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - 加载三方登陆以后的头像和昵称
- (void)addUserNameAndUserIcon
{
//    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo.txt"];//当前应用的沙盒路径
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:USERINFOPATH];
    
    UserInfoModel *model = [array objectAtIndex:0];
    if (model) {
        //如果沙盒中存储与输入的值形同的模型，则做出相应操作之后，跳出整个函数
        [_logoImage sd_setImageWithURL:[NSURL URLWithString:model.iconUrlStr] placeholderImage:[UIImage imageNamed:@"head_default.png"]];
        _nameLabel.text = model.userNameStr;
    } else {
        _nameLabel.text = @"昵称";
    }
    
    [self goBack];
}

#pragma mark -
#pragma mark - 懒加载
- (UIImageView *)logoImage
{
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-50, 90, 100, 100)];
        _logoImage.layer.cornerRadius = 50;
        _logoImage.layer.masksToBounds = YES;
        _logoImage.backgroundColor = [UIColor redColor];
        _logoImage.image = [UIImage imageNamed:@"logo"];

    }
    return _logoImage;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-100, 190, 200, 50)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:30];
        _nameLabel.text = @"众商智推";
    }
    return _nameLabel;
}
//线
- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(10, ScreenHeight - 260, ScreenWidth - 20, 1)];
        [_lineView setBackgroundColor:[UIColor grayColor]];
    }
    return _lineView;
}
//messageLabel
- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, ScreenHeight - 270, ScreenWidth - 10, 30)];
        _messageLabel.text = @"选择登录方式";
        [_messageLabel sizeToFit];
        _messageLabel.centerX = self.lineView.centerX;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:14];
        _messageLabel.textColor = [UIColor grayColor];
        _messageLabel.backgroundColor = [UIColor clearColor];
    }
    return _messageLabel;
}

//weiXinBtn
- (UIButton *)weiXinBtn
{
    if (!_weiXinBtn) {
        _weiXinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _weiXinBtn.frame = CGRectMake(30, ScreenHeight - 220, ScreenWidth - 60, 50);
        [_weiXinBtn setImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
        [_weiXinBtn setTitle:@"微信登录" forState:UIControlStateNormal];
        [_weiXinBtn setTitleColor:ZSColor(0, 181, 93) forState:UIControlStateNormal];
        _weiXinBtn.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 0, 50);
        _weiXinBtn.titleEdgeInsets = UIEdgeInsetsMake(3, 50, 0, 1);
        _weiXinBtn.layer.cornerRadius = 25;
        _weiXinBtn.layer.masksToBounds = YES;
        _weiXinBtn.layer.borderWidth = 1;
        _weiXinBtn.layer.borderColor = [UIColor greenColor].CGColor;
        [_weiXinBtn setBackgroundColor:[UIColor clearColor]];
//        [_weiXinBtn setBackgroundColor:ZSColor(0, 181, 93)];
        [_weiXinBtn addTarget:self action:@selector(showWeiXin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weiXinBtn;
}
//qqBtn
- (UIButton *)qqBtn
{
    if (!_qqBtn) {
        _qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _qqBtn.frame = CGRectMake(30, ScreenHeight - 160, ScreenWidth - 60, 50);
        [_qqBtn setImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateNormal];
        [_qqBtn setTitle:@"QQ登录" forState:UIControlStateNormal];
        [_qqBtn setTitleColor:ZSColor(0, 163, 226) forState:UIControlStateNormal];
        _qqBtn.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 0, 50);
        _qqBtn.titleEdgeInsets = UIEdgeInsetsMake(3, 50, 0, 1);
        _qqBtn.layer.cornerRadius = 25;
        _qqBtn.layer.masksToBounds = YES;
        _qqBtn.layer.borderWidth = 1;
        _qqBtn.layer.borderColor = [UIColor blueColor].CGColor;
//        [_qqBtn setBackgroundColor:ZSColor(0, 163, 226)];
         [_qqBtn setBackgroundColor:[UIColor clearColor]];
        [_qqBtn addTarget:self action:@selector(showQQ) forControlEvents:UIControlEventTouchUpInside];
//        _qqBtn.layer.cornerRadius = 25;
//        _qqBtn.layer.masksToBounds = YES;
    }
    return _qqBtn;
}
//sinaBtn
- (UIButton *)sinaBtn
{
    if (!_sinaBtn) {
        _sinaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sinaBtn.frame = CGRectMake(30, ScreenHeight - 100, ScreenWidth - 60, 50);

        [_sinaBtn setImage:[UIImage imageNamed:@"新浪"] forState:UIControlStateNormal];
        [_sinaBtn setTitle:@"新浪登录" forState:UIControlStateNormal];
        [_sinaBtn setTitleColor: ZSColor(244, 9, 10) forState:UIControlStateNormal];
        _sinaBtn.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 0, 50);
        _sinaBtn.titleEdgeInsets = UIEdgeInsetsMake(3, 50, 0, 1);
        _sinaBtn.layer.cornerRadius = 25;
        _sinaBtn.layer.masksToBounds = YES;
        _sinaBtn.layer.borderWidth = 1;
        _sinaBtn.layer.borderColor = [UIColor redColor].CGColor;
       [_sinaBtn setBackgroundColor:[UIColor clearColor]];
//        [_sinaBtn setBackgroundColor:ZSColor(244, 9, 10)];
        [_sinaBtn addTarget:self action:@selector(showSina) forControlEvents:UIControlEventTouchUpInside];
        //        _sinaBtn.layer.cornerRadius = 25;
        //        _sinaBtn.layer.masksToBounds = YES;
    }
    return _sinaBtn;
}

//新浪，QQ，微信的实现方法
-(void)showSina
{
    [self sanFangDengLuWithType:UMShareToSina];
}
-(void)showQQ
{
    [self sanFangDengLuWithType:UMShareToQQ];
}
-(void)showWeiXin
{
    [self sanFangDengLuWithType:UMShareToWechatSession];
}

- (void)sanFangDengLuWithType:(NSString *)type
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:type];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            //            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            //            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
            
            ZSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            ZSLog(@"%@",snsAccount);
            
            //保存用户的头像和昵称
            NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:USERINFOPATH];//将沙盒路径下的归档对象解档出来
            if (array == nil) {
                array = [NSMutableArray array];
            }
            UserInfoModel *userInfoModel = [[UserInfoModel alloc] init];
            userInfoModel.iconUrlStr = snsAccount.iconURL;
            userInfoModel.userNameStr = snsAccount.userName;
            userInfoModel.userIdStr = snsAccount.usid;
            [array insertObject:userInfoModel atIndex:0];
            
            ZSLog(@"%@",array);
            
            //把刚才写的数组存到沙盒当中去
            if ([NSKeyedArchiver archiveRootObject:array toFile:USERINFOPATH]) {
                ZSLog(@"保存成功");
                //                [self backToLoginViewController];
            }else{
                ZSLog(@"保存失败");
            }
            
            ZSLog(@"%@",USERINFOPATH);
            NSArray *list = (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithFile:USERINFOPATH];
            ZSLog(@"%@",list);
//            [self addUserNameAndUserIcon];
            //用通知传值显示改变编辑后的内容
            NSNumber *number = [[NSNumber alloc] initWithInt:1];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"passValue1" object:number];
 
            //登陆成功以后发给服务器用户的id
//            [self sendUserIDToServerWithID:snsAccount.usid];
            [self goBack];
        }
        
    });
    
//    self.loginClickHandler 
}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:YES];
////    ProfileViewController *profileVC = [[ProfileViewController alloc] init];
//////    [profileVC removeSelfAndLoginVC];
////    profileVC.loginVC = nil;
////    profileVC.coverBtn = nil;
//    [self.view removeFromSuperview];
//    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0.1];
//    NSLog(@"loginDisappearTime:%@",date);
//
//
//    
//}
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0.1];
//    NSLog(@"loginappearTime:%@",date);
//}
/** 定义响应点击各平台授权登录后的block对象
 
 @param presentingController 点击后弹出的分享页面或者授权页面所在的UIViewController对象
 @param socialControllerService 可以用此对象的socialControllerService.socialData可以获取分享内嵌文字、内嵌图片，分享次数等
 @param isPresentInController 如果YES代表弹出(present)到当前UIViewController，否则push到UIViewController的navigationController
 @param completion 授权完成之后的回调对象，返回的response参数表示成功与否和拿到的授权信息
 
 */

//typedef void (^UMSocialSnsPlatformLoginHandler)(UIViewController *presentingController, UMSocialControllerService * socialControllerService, BOOL isPresentInController, UMSocialDataServiceCompletion completion);






#pragma mark -
#pragma mark -  登陆成功以后发给服务器用户的id
- (void)sendUserIDToServerWithID:(NSString *)userID
{
    
//    if (userID) {
        NSDictionary *parametDic = @{@"userid":userID};
        [AFNetworkUtil postDictWithUrl:UPLOADUSERINFO_STRURL parameters:parametDic successBackData:^(NSData *data) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            ZSLog(@"------------------\n%@",dict);
            ZSLog(@"11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111");
            
            //请求成功以后刷新表格
            //请求成功，loading界面消失
            [LiangView removeLiangViewFromSuperView:self.view];
        } fail:^{
            NSError *error;
            if (error) {
                ZSLog(@"%@",error);
            }
            
            [MBProgressHUD showError:@"请求超时！"];
            //请求失败，loading界面消失
            [LiangView removeLiangViewFromSuperView:self.view];
            
        }];

//    } else {
//        [MBProgressHUD showError:@"登录失败！"];
//    }

}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self goBack];
//}

@end
