//
//  FreelancerProfileViewController.m
//  BridgeApp
//
//  Created by David Tong on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "FreelancerProfileViewController.h"
#import "PortfolioCell.h"

@interface FreelancerProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *numOfReviewsLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) User *user;


@end

@implementation FreelancerProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.nameLabel.text = self.user.username;
    
    NSMutableString *starString = [[NSMutableString alloc] init];
    if (self.user.rating == NULL) {
        for (int i = 0; i < (int)self.user.rating; i++) {
            [starString appendString:@"★"];
        }
    } else {
        [starString setString:@"newbie"];
    }
    self.starLabel.text = starString;
    
    NSString *reviewCount = nil;
    if (self.user.reviewCount) {
        reviewCount = [NSString stringWithFormat:@"%ld Reviews", (long)self.user.reviewCount];
    } else {
        reviewCount = @"0 Review";
    }
    self.numOfReviewsLabel.text = reviewCount;

    NSString *filename = @"profile1.jpg";
    self.profileImageView.image = [UIImage imageNamed:filename];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"PortfolioCell"];
    
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PortfolioCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PortfolioCell" forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"clicked cell");
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 20, 50, 20);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(130, 130);
    return size;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (FreelancerProfileViewController *)initWithUser:(User *)user {
    self.user = user;
    return self;
}

@end