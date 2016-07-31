//
//  ADTableViewCell.m
//  众商智推
//
//  Created by VINCENT on 16/7/29.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "ADTableViewCell.h"
#import "MJExtension.h"
@implementation ADTableViewCell
MJCodingImplementation
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configTempCellWith:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
            break;
    }
}

+ (ADTableViewCell*)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"";//对应xib中设置的identifier
    NSInteger index = 0; //xib中第几个Cell
    switch (indexPath.row) {
        case 0:
            identifier = @"ADTableViewCellOne";
            index = 0;
            break;
        case 1:
            identifier = @"ADTableViewCellTwo";
            index = 1;
            break;
        case 2:
            identifier = @"ADTableViewCellThree";
            index = 2;
            break;
        case 3:
            identifier = @"ADTableViewCellFour";
            index = 3;
            break;
        case 4:
            identifier = @"ADTableViewCellFive";
            index = 4;
            break;

        default:
            break;
    }
    ADTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ADTableViewCell" owner:self options:nil] objectAtIndex:index];
    }
    return cell;
    
}




@end
