//
//  MJCollectionViewCell.m
//  RCCPeakableImageSample
//
//  Created by Mayur on 4/1/14.
//  Copyright (c) 2014 RCCBox. All rights reserved.
//

#import "MJCollectionViewCell.h"

@interface MJCollectionViewCell()

@end

@implementation MJCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) [self setupSubViews];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) [self setupSubViews];
    return self;
}


-(void)dealloc{
    
    [self.MJImageView release];
    [self.cnnameLabel release];
    [self.ennameLabel release];
    [self.image release];
    [super dealloc];
}


#pragma mark - Setup Method
- (void)setupSubViews
{
    
    // Clip subviews
    self.clipsToBounds = YES;

    // Add image subview
    self.MJImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, IMAGE_HEIGHT_1)];
    self.MJImageView.backgroundColor = [UIColor redColor];
    self.MJImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.MJImageView.clipsToBounds = NO;
    
    //国家中文名标签
    CGFloat  labelY = self.MJImageView.frame.origin.y + self.MJImageView.frame.size.height - 70;
    self.cnnameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,labelY , self.MJImageView.frame.size.width, 30)];
    self.ennameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                               self.cnnameLabel.frame.origin.y + self.cnnameLabel.frame.size.height,
                                                               self.MJImageView.frame.size.width,
                                                               30)];
    self.cnnameLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE];
    self.ennameLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 5];
    self.cnnameLabel.backgroundColor = [UIColor clearColor];
    self.ennameLabel.backgroundColor = [UIColor clearColor];
    self.cnnameLabel.textColor = LABEL_COLOR;
    self.ennameLabel.textColor = LABEL_COLOR;
    self.cnnameLabel.contentMode = UIViewContentModeScaleAspectFill;
    self.ennameLabel.contentMode = UIViewContentModeScaleAspectFill;
    self.cnnameLabel.shadowColor = [UIColor blackColor];
    self.ennameLabel.shadowColor = [UIColor blackColor];
//    [self.cnnameLabel setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
//    [self.ennameLabel setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    
    [self addSubview:self.MJImageView];
//    [self.MJImageView addSubview:self.ennameLabel];
//    [self.MJImageView addSubview:self.cnnameLabel];
    [self addSubview:self.ennameLabel];
    [self addSubview:self.cnnameLabel];
    [self.MJImageView release];
    [self.cnnameLabel release];
    [self.ennameLabel release];
}

# pragma mark - Setters

- (void)setImage:(UIImage *)image
{
    // Store image
    self.MJImageView.image = image;
    
    // Update padding
    [self setImageOffset:self.imageOffset];
}

- (void)setImageOffset:(CGPoint)imageOffset
{
    // Store padding value
    _imageOffset = imageOffset;

    // Grow image view
    CGRect frame = self.MJImageView.bounds;
    CGRect offsetFrame = CGRectOffset(frame, _imageOffset.x, _imageOffset.y);
    self.MJImageView.frame = offsetFrame;

}


@end
