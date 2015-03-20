//
//  BusinessCell.m
//  BridgeApp
//
//  Created by Shrikar Archak on 3/7/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "BusinessCell.h"
#import "FreelancerProfileViewController.h"

@implementation BusinessCell

- (void)awakeFromNib {
    // Initialization code
    self.profileImage.layer.cornerRadius = 27.5;
    self.summary.preferredMaxLayoutWidth = self.summary.frame.size.width;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onProfileTap:)];
    tap.numberOfTapsRequired = 1;
    self.profileImage.userInteractionEnabled = YES; //if you want touch on your image you'll need this
    [self.profileImage addGestureRecognizer:tap];
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

-(void) layoutSubviews{
    [super layoutSubviews];
    self.summary.preferredMaxLayoutWidth = self.summary.frame.size.width;
}


- (IBAction)onProfileTap:(UITapGestureRecognizer *)sender {
    
    
    FreelancerProfileViewController * fpvc = [[FreelancerProfileViewController alloc] initWithUser:[User currentUser]];

    //[self presentViewController:fpvc animated:NO completion:nil];

    

}

@end
