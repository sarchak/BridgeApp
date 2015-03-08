//
//  JobCell.m
//  BridgeApp
//
//  Created by David Tong on 3/7/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "JobCell.h"

@implementation JobCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setJob:(Job *)job {
    self.titleLabel.text = job.title;
    self.summaryLabel.text = job.jobDescription;
    self.priceLabel.text = [NSString stringWithFormat:@"%@", job.price];
}

@end
