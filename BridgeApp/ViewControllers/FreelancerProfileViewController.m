//
//  FreelancerProfileViewController.m
//  BridgeApp
//
//  Created by David Tong on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "FreelancerProfileViewController.h"
#import "PortfolioCell.h"
#import "PastJobCell.h"
#import <RateView.h>

@interface FreelancerProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *numOfReviewsLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) User *user;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *availableButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) NSArray *completedJobs;


@end

@implementation FreelancerProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.nameLabel.text = self.user.username;
    
//    NSMutableString *starString = [[NSMutableString alloc] init];
//    if (self.user.rating == NULL) {
//        for (int i = 0; i < (int)self.user.rating; i++) {
//            [starString appendString:@"★"];
//        }
//    } else {
//        [starString setString:@"newbie"];
//    }
//    self.starLabel.text = starString;
    
    if ([self.user.rating isEqual:[NSNull null]] || [self.user.rating isEqualToNumber:0]) {
        UILabel *starLabelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [starLabelView setText:@"newbie"];
        starLabelView.tintColor = [UIColor blackColor];
        [self.starView addSubview:starLabelView];

    } else {
        [self.starView addSubview:[RateView rateViewWithRating:[self.user.rating floatValue]]];
    }
    
    
    NSString *reviewCount = nil;
    if (self.user.reviewCount) {
        reviewCount = [NSString stringWithFormat:@"%ld Reviews", (long)self.user.reviewCount];
    } else {
        reviewCount = @"0 Review";
    }
    self.numOfReviewsLabel.text = reviewCount;

    NSString *filename = @"profile1.jpg";
    self.profileImageView.image = [UIImage imageNamed:filename];
    self.profileImageView.contentMode = UIViewContentModeScaleToFill;
    self.profileImageView.layer.cornerRadius = 30;
    self.profileImageView.layer.masksToBounds = YES;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"PortfolioCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"PortfolioCell" bundle:nil] forCellWithReuseIdentifier:@"PortfolioCell"];
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_wood.jpg"]];
    self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"california-san-francisco-neighborhoods.jpg"]];
    [self.collectionView reloadData];
    
    self.tableView.alpha = 0.0f;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"PastJobCell" bundle:nil] forCellReuseIdentifier:@"PastJobCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;

    self.segmentedControl.layer.cornerRadius = 5;
    
    // @TODO(dtong) change to JobStatusApproved. Now JobStatusAssigned is for demo only!!!!!!!!!!!!!!!!!
    [Job getJobAssignedToUserWithStatus:self.user status:JobStatusAssigned completion:^(NSArray *foundObjects, NSError *error) {
        self.completedJobs = foundObjects;
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PortfolioCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PortfolioCell" forIndexPath:indexPath];
    
    //cell.photo = [UIImage imageNamed:@"bridge.png"];
    //imageView.clipsToBounds = YES;
    //cell.someLabel.text = @".p";
    [cell setPhoto:[UIImage imageNamed:[NSString stringWithFormat:@"portfolio%ld.jpg", (long)indexPath.row + 1]]];

    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"clicked cell");
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(-10, 20, 30, 20);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(140, 140);
    return size;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.completedJobs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PastJobCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PastJobCell"];
    cell.job = self.completedJobs[indexPath.row];
    cell.jobTitleLabel.text = cell.job.title;
    return cell;
}

- (IBAction)onAvailableButton:(id)sender {
    if (self.availableButton.tintColor != [UIColor grayColor]) {
        [self.availableButton setTitle:@"Unavailable" forState:UIControlStateNormal];
        //self.availableButton.enabled = NO;
        self.availableButton.tintColor = [UIColor grayColor];
    } else {
        [self.availableButton setTitle:@"Available" forState:UIControlStateNormal];
        self.availableButton.tintColor = [UIColor lightTextColor];
        //self.availableButton.enabled = YES;
    }
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

- (IBAction)onSegmentedChanged:(id)sender {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        self.collectionView.alpha = 1;
        self.tableView.alpha = 0;
    } else {
        self.collectionView.alpha = 0;
        self.tableView.alpha = 1;
    }
}

@end