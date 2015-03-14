//
//  BusinessOwnerCell.h
//  BridgeApp
//
//  Created by Shrikar Archak on 3/13/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"

@interface BusinessOwnerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *businessName;
@property (weak, nonatomic) IBOutlet RateView *ratingView;


@end
