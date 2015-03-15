//
//  PortfolioCell.h
//  BridgeApp
//
//  Created by David Tong on 3/14/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PortfolioCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *portfolioPosterView;
@property (strong, nonatomic) UIImage *photo;

-(void)setPhoto:(UIImage *)photo;
@end
