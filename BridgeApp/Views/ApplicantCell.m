//
//  ApplicantCell.m
//  BridgeApp
//
//  Created by Shrikar Archak on 3/13/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "ApplicantCell.h"

@implementation ApplicantCell

- (void)awakeFromNib {
    // Initialization code
    self.profileImageView.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
