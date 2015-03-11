//
//  BusinessCell.m
//  BridgeApp
//
//  Created by Shrikar Archak on 3/7/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "BusinessCell.h"

@implementation BusinessCell

- (void)awakeFromNib {
    // Initialization code
    self.profileImage.layer.cornerRadius = 27.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)apply:(id)sender {
    self.assignButton.enabled = NO;
    [self.assignButton setTitle:@"Assigned" forState:UIControlStateNormal];
    [self.delegate businessCell:self apply:YES];
}

@end
