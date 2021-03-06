//
//  TitleSubtitleCell.h
//  BridgeApp
//
//  Created by Shrikar Archak on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TitleSubtitleCell;

@protocol TitleSubtitleCellDelegate <NSObject>
-(void) titleSubtitleCell:(TitleSubtitleCell*) cell iconTapped:(BOOL) tapped;
@end

@interface TitleSubtitleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) id<TitleSubtitleCellDelegate> delegate;
@end
