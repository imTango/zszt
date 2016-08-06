//
//  ADFiveTableViewCell.h
//  众商智推
//
//  Created by VINCENT on 16/8/3.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdtypeFiveModel.h"
@interface ADFiveTableViewCell : UITableViewCell

@property (strong, nonatomic)  UIImageView * fifthBgImg;
@property (strong, nonatomic)  UILabel * fifthAdTitle;
@property (nonatomic,strong)   NSString * fifthUrl;

-(void)loadDataWithModel:(AdtypeFiveModel*)model indexPath:(NSIndexPath *)indexpath;
@end
