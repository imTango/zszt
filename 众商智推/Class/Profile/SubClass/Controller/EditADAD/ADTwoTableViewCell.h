//
//  ADTwoTableViewCell.h
//  众商智推
//
//  Created by VINCENT on 16/8/3.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdtypeTwoModel.h"
@interface ADTwoTableViewCell : UITableViewCell

@property (strong, nonatomic)  UIImageView * secIconImg;
@property (strong, nonatomic)  UILabel * secAdTitle;
@property (strong, nonatomic)  UILabel * secAdDescrible;
@property (nonatomic, strong)  NSString * secUrl;

-(void)loadDataWithModel:(AdtypeTwoModel*)model indexPath:(NSIndexPath *)indexpath;

@end
