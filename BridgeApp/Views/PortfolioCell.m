//
//  PortfolioCell.m
//  BridgeApp
//
//  Created by David Tong on 3/14/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "PortfolioCell.h"

@implementation PortfolioCell

- (void)awakeFromNib {
    // Initialization code
    //[self.portfolioPosterView setImage:self.poster];

}

- (void)setPhoto:(UIImage *)photo{
    if (_photo != photo) {
        _photo = photo;
    }
    self.portfolioPosterView.image = photo;
}

@end
