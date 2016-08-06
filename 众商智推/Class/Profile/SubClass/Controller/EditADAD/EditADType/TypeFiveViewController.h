//
//  TypeFiveViewController.h
//  众商智推
//
//  Created by 杨 on 16/7/12.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeFiveViewController : UIViewController

/**
 *广告语
 */
@property (strong, nonatomic) UITextField *adTextField;
/**
 *广告链接
 */
@property (strong, nonatomic) UITextField *linkTextField;
//广告背景图片
@property (nonatomic,strong) NSData * imgData;

@end
