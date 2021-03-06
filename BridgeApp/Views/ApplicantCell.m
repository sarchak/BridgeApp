//
//  ApplicantCell.m
//  BridgeApp
//
//  Created by Shrikar Archak on 3/13/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "ApplicantCell.h"
#import "Constants.h"

@implementation ApplicantCell

- (void)awakeFromNib {
    // Initialization code
    self.profileImageView.layer.cornerRadius = 5;
    self.backgroundColor = TABLEVIEWCELLCOLOR;
    self.ratingView.backgroundColor = TABLEVIEWCELLCOLOR;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onProfileTap:)];
    tap.numberOfTapsRequired = 1;
    self.profileImageView.userInteractionEnabled = YES; //if you want touch on your image you'll need this
    [self.profileImageView addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)onProfileTap:(UITapGestureRecognizer *)sender {
    [self.delegate applicantCell:self];
}
@end
