//
//  ADFiveTableViewCell.m
//  众商智推
//
//  Created by VINCENT on 16/8/3.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "ADFiveTableViewCell.h"

@implementation ADFiveTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];

    }
    return self;
}


-(void)createUI{
    self.fifthBgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90)];
    [self.contentView addSubview:self.fifthBgImg];
    
    self.fifthAdTitle = [[UILabel alloc] initWithFrame:self.fifthBgImg.frame];
    self.fifthAdTitle.font = [UIFont systemFontOfSize:25 weight:10];
    self.fifthAdTitle.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.fifthAdTitle];
}

-(void)loadDataWithModel:(AdtypeFiveModel*)model indexPath:(NSIndexPath *)indexpath{
    self.fifthBgImg.image = [UIImage imageWithData:model.bgImg];
    self. fifthAdTitle.text = model.adTitle;
    self.fifthUrl = model.url;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
