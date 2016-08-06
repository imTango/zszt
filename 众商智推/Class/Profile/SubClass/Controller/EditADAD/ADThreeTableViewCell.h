//
//  ADThreeTableViewCell.h
//  众商智推
//
//  Created by VINCENT on 16/8/3.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdtypeThreeModel.h"
@interface ADThreeTableViewCell : UITableViewCell

@property (strong, nonatomic)  UIImageView * thirdBgImg;
@property (strong, nonatomic)  UIButton * thirdFocusBtn;
@property (strong, nonatomic)  UILabel * thirdAdTitle;
@property (nonatomic,strong)  NSString * thirdUrl;

-(void)loadDataWithModel:(AdtypeThreeModel*)model indexPath:(NSIndexPath *)indexpath;

@end
