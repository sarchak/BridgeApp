//
//  PriceViewController.h
//  BridgeApp
//
//  Created by Shrikar Archak on 3/7/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Job.h"

@class PriceViewController;

@protocol PriceViewControllerDelegate <NSObject>
-(void) priceViewController: (PriceViewController*) priceViewController valueChanged:(BOOL)value;
@end

@interface PriceViewController : UIViewController
@property (nonatomic, weak) Job *job;
@property (nonatomic, weak) id<PriceViewControllerDelegate> delegate;
@end
