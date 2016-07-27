//
//  ProfileViewController.h
//  众商智推
//
//  Created by 杨 on 16/4/8.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
@interface ProfileViewController : UIViewController

@property (strong, nonatomic) LoginViewController *loginVC;

//阴影按钮
@property (strong, nonatomic) UIButton *coverBtn;

+ (ProfileViewController*)share;
- (void)removeSelfAndLoginVC;

@end
