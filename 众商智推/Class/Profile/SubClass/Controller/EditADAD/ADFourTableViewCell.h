//
//  ADFourTableViewCell.h
//  众商智推
//
//  Created by VINCENT on 16/8/3.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdtypeFourModel.h"
@interface ADFourTableViewCell : UITableViewCell

@property (strong, nonatomic)  UIImageView * fourthIconImg;
@property (strong, nonatomic)  UILabel * fourthAdTitle;
@property (strong, nonatomic)  UILabel * fourthAdDescrible;
@property (strong, nonatomic)  UIButton * fourthFocusBtn;
@property (nonatomic, strong)  NSString * fourthUrl;
@property (nonatomic, strong)  NSString * adId;

-(void)loadDataWithModel:(AdtypeFourModel*)model indexPath:(NSIndexPath *)indexpath;

@end
