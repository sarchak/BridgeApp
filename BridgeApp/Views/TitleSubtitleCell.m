//
//  TitleSubtitleCell.m
//  BridgeApp
//
//  Created by Shrikar Archak on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "TitleSubtitleCell.h"

@implementation TitleSubtitleCell

- (void)awakeFromNib {
    // Initialization code
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTapped)];
    [self.iconImageView addGestureRecognizer:gesture];

}


-(void) iconTapped{
    [self.delegate titleSubtitleCell:self iconTapped:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
