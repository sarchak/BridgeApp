//
//  ApplicantCell.h
//  BridgeApp
//
//  Created by Shrikar Archak on 3/13/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"
#import "SWTableViewCell.h"
#import "User.h"

@class ApplicantCell;

@protocol ApplicantCellDelegate <SWTableViewCellDelegate>

-(void) onProfileTap: (User*) user;

@end

@interface ApplicantCell : SWTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *summary;
@property (weak, nonatomic) IBOutlet RateView *ratingView;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) id<ApplicantCellDelegate> delegate;

@end
