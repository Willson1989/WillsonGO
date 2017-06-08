//
//  SearchListCell.m
//  XinTu
//
//  Created by WillHelen on 15/7/4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SearchListCell.h"



@implementation SearchListCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubView];
    }
    return self;
}

-(void)setSearchResult:(SearchResult *)searchResult{
    if (_searchResult != searchResult) {
        [_searchResult release];
        _searchResult = [searchResult retain];
    }
    self.cnnameLabel.text = searchResult.cnname;
    self.ennameLabel.text = searchResult.enname;
    NSLog(@"%@ / %@",searchResult.parent_parentname,searchResult.parentname);
    if ([searchResult.parent_parentname isEqualToString:@""]) {
        self.belongLabel.text = searchResult.parentname;
    }
    else if ([searchResult.parentname isEqualToString:@""]){
        self.belongLabel.text = searchResult.parent_parentname;
    }
    else{
        self.belongLabel.text = [NSString stringWithFormat:@"%@/%@",searchResult.parent_parentname,searchResult.parentname];
    }
    self.catgoryLabel.text = searchResult.label;
    [self.resultImage sd_setImageWithURL:[NSURL URLWithString:searchResult.photo]
                        placeholderImage:[UIImage imageNamed:PHOLDER_IMAGE_NAME]];
    self.beenToLabel.text = searchResult.beenstr;
}


-(void)createSubView{
    self.resultImage = [[UIImageView alloc]initWithFrame:CGRectMake(RESULT_CELL_INSET,
                                                                    RESULT_CELL_INSET,
                                                                    (CGRectGetWidth([[UIScreen mainScreen]bounds]) - RESULT_CELL_INSET*2)/4,
                                                                    (CGRectGetWidth([[UIScreen mainScreen]bounds]) - RESULT_CELL_INSET*2)/4)];
    self.cnnameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.resultImage.frame.origin.x + self.resultImage.frame.size.width + RESULT_CELL_INSET,
                                                                self.resultImage.frame.origin.y,
                                                                CGRectGetWidth([[UIScreen mainScreen]bounds]) - RESULT_CELL_INSET*6 - self.resultImage.frame.size.width,
                                                                self.resultImage.frame.size.height / 5)];
    self.cnnameLabel.textAlignment = NSTextAlignmentLeft;
    self.cnnameLabel.textColor = [UIColor blackColor];
    self.cnnameLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 3];
    
    self.ennameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.cnnameLabel.frame.origin.x,
                                                                self.cnnameLabel.frame.origin.y + self.cnnameLabel.frame.size.height,
                                                                self.cnnameLabel.frame.size.width,
                                                                self.cnnameLabel.frame.size.height)];
    self.ennameLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 5];
    self.ennameLabel.textColor = [UIColor grayColor];
    self.ennameLabel.textAlignment = NSTextAlignmentLeft;

    
    self.belongLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.ennameLabel.frame.origin.x,
                                                                 self.ennameLabel.frame.origin.y + self.ennameLabel.frame.size.height*2,
                                                                 self.ennameLabel.frame.size.width,
                                                                 self.ennameLabel.frame.size.height)];
    self.belongLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 5];
    self.belongLabel.textColor = [UIColor grayColor];
    self.belongLabel.textAlignment = NSTextAlignmentLeft;
    
    self.beenToLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.belongLabel.frame.origin.x,
                                                                self.belongLabel.frame.origin.y + self.belongLabel.frame.size.height,
                                                                self.belongLabel.frame.size.width,
                                                                self.belongLabel.frame.size.height)];
    self.beenToLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 5];
    self.beenToLabel.textColor = [UIColor grayColor];
    self.beenToLabel.textAlignment = NSTextAlignmentLeft;
    
    self.catgoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth([[UIScreen mainScreen]bounds]) - RESULT_CELL_INSET*4,
                                                                 RESULT_CELL_INSET,
                                                                 RESULT_CELL_INSET*4,
                                                                 self.resultImage.frame.size.height)];
    self.catgoryLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 4];
    self.catgoryLabel.textColor = [UIColor grayColor];
    self.catgoryLabel.textAlignment = NSTextAlignmentCenter;
    
//    self.cnnameLabel.backgroundColor = [UIColor redColor];
//    self.ennameLabel.backgroundColor = [UIColor yellowColor];
//    self.catgoryLabel.backgroundColor = [UIColor blueColor];
//    self.belongLabel.backgroundColor = [UIColor greenColor];
//    self.beenToLabel.backgroundColor = [UIColor grayColor];

    
    self.cnnameLabel.numberOfLines = 0;
    self.ennameLabel.numberOfLines = 0;
    self.catgoryLabel.numberOfLines = 0;
    self.beenToLabel.numberOfLines = 0;

    [self.contentView addSubview:self.catgoryLabel];
    [self.contentView addSubview:self.beenToLabel];
    [self.contentView addSubview:self.belongLabel];
    [self.contentView addSubview:self.ennameLabel];
    [self.contentView addSubview:self.cnnameLabel];
    [self.contentView addSubview:self.resultImage];
    
    [self.catgoryLabel release];
    [self.beenToLabel release];
    [self.belongLabel release];
    [self.ennameLabel release];
    [self.cnnameLabel release];
    [self.resultImage release];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
