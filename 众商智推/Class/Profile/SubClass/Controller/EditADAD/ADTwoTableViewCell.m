//
//  ADTwoTableViewCell.m
//  众商智推
//
//  Created by VINCENT on 16/8/3.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "ADTwoTableViewCell.h"

@implementation ADTwoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];

    }
    return self;
}


-(void)createUI{
    self.secIconImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 70)];
    [self.contentView addSubview:self.secIconImg];
    self.secAdTitle = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, ScreenWidth-90-100, 30)];
    self.secAdTitle.font = [UIFont systemFontOfSize:25 weight:10];
    [self.contentView addSubview:self.secAdTitle];
    self.secAdDescrible = [[UILabel alloc] initWithFrame:CGRectMake(90, 50, ScreenWidth-90-30, 20)];
    self.secAdDescrible.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.secAdDescrible];
}

-(void)loadDataWithModel:(AdtypeTwoModel*)model indexPath:(NSIndexPath *)indexpath{
    self.secIconImg.image = [UIImage imageWithData:model.image];
    self.secAdTitle.text = model.title;
    self.secAdDescrible.text = model.content;
    self.secUrl = model.adurl;
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
