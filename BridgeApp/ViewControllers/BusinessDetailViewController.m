//
//  BusinessDetailViewController.m
//  BridgeApp
//
//  Created by Shrikar Archak on 3/8/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "BusinessDetailViewController.h"
#import "Constants.h"
#import "ApplicantCell.h"
#import "Job.h"
#import "MessagesViewController.h"
#import "ChatMessageThread.h"
#import "ChameleonFramework/Chameleon.h"
#import "SWTableViewCell.h"

@interface BusinessDetailViewController () <SWTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobDescription;
@property (weak, nonatomic) IBOutlet UILabel *dueDate;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BusinessDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.titleLabel.text = self.job.title;
    self.jobDescription.text = self.job.jobDescription;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor flatWhiteColor];    
    [self.tableView registerNib:[UINib nibWithNibName:@"ApplicantCell" bundle:nil] forCellReuseIdentifier:@"ApplicantCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Applicants";
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.job.applicants.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ApplicantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplicantCell"];
    User *user = self.job.applicants[indexPath.row];
    NSLog(@"%@", user.username);
    
    cell.nameLabel.text = user.username;
    cell.summary.text = @"Some summary about this guy";
    NSInteger num = (indexPath.row % 3) + 1;
    NSString *filename = [NSString stringWithFormat:@"profile%ld.jpg", num];
    cell.profileImageView.image = [UIImage imageNamed:filename];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.ratingView.rating = 3.75;
    cell.ratingView.starSize = 15;
    cell.ratingView.starFillColor = [UIColor orangeColor];

    
    if(user.objectId == self.job.assignedToUser.objectId){
        cell.statusView.backgroundColor = [UIColor flatGreenColor];
    } else {
        /* Assign button */
        NSMutableArray *leftUtilityButtons = [NSMutableArray new];
        [leftUtilityButtons sw_addUtilityButtonWithColor: [UIColor flatGreenColor]
                                                   title:@"Assign"];
        cell.leftUtilityButtons = leftUtilityButtons;
        cell.delegate = self;
        
    }
    return cell;
}

-(void) businessCell:(BusinessCell *)businessCell apply:(BOOL)value{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:businessCell];
    User *user = self.job.applicants[indexPath.row];
    self.job.status = JobStatusAssigned;
    self.job.assignedToUser = user;
    [self.job saveWithCompletion:^(NSError *error) {
        NSLog(@"Job status updated to assigned");
        [[NSNotificationCenter defaultCenter] postNotificationName:JOBSTATUSCHANGED object:nil userInfo:nil];
    }];
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    MessagesViewController *mvc = [[MessagesViewController alloc] init];
    mvc.fromUser = [User currentUser];

    User *user = self.job.applicants[indexPath.row];
    
    [ChatMessageThread createMessageThread:self.job.objectId businessId:self.job.owner.objectId freelancerId:user.objectId completion:^(NSString *threadID, NSError *error) {
        NSLog(@"### Thread id :%@", threadID);
        mvc.threadId = threadID;
        [self.navigationController pushViewController:mvc animated:YES];
    }];

}

-(void) swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    User *user = self.job.applicants[indexPath.row];
    self.job.status = JobStatusAssigned;
    self.job.assignedToUser = user;
    [self.job saveWithCompletion:^(NSError *error) {
        NSLog(@"Job status updated to assigned");
        [[NSNotificationCenter defaultCenter] postNotificationName:JOBSTATUSCHANGED object:nil userInfo:nil];
    }];
    [cell hideUtilityButtonsAnimated:YES];
}

@end
