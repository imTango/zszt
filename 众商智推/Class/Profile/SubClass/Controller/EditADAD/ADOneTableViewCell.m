//
//  ADOneTableViewCell.m
//  众商智推
//
//  Created by VINCENT on 16/8/3.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "ADOneTableViewCell.h"

@implementation ADOneTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
        
    }
    return self;
}
-(void)createUI{
    self.firstBgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90)];
    [self.contentView addSubview:self.firstBgImg];
    
    self.fisrtADLabel = [[UILabel alloc] initWithFrame:self.firstBgImg.frame];
    self.fisrtADLabel.textAlignment = NSTextAlignmentCenter;
    self.fisrtADLabel.font = [UIFont systemFontOfSize:25 weight:10];
    [self.contentView addSubview:self.fisrtADLabel];
}

-(void)loadDataWithModel:(AdtypeOneModel*)model indexPath:(NSIndexPath *)indexpath{
    self.firstBgImg.image = [UIImage imageWithData:model.image];
    self.fisrtADLabel.text = model.title;
    self.firstUrl = model.adurl;
    self.adId = model.adId;

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
