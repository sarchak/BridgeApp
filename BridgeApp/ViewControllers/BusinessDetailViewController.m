//
//  BusinessDetailViewController.m
//  BridgeApp
//
//  Created by Shrikar Archak on 3/8/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "BusinessDetailViewController.h"
#import "Constants.h"
#import "BusinessCell.h"
#import "Job.h"

@interface BusinessDetailViewController ()
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
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];
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

//- (void)setButtonState {
//    self.assignButton.enabled = YES;
//    // disable certain buttons if applicable
//    if ([self.job hasUserApplied:[User currentUser]]) {
//        [self setAppliedButton];
//    }
//}
//- (void)setAppliedButton {
//    self.applyButton.enabled = NO;
//    [self.applyButton setTitle:@"Applied" forState:UIControlStateNormal];
//}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    User *user = self.job.applicants[indexPath.row];
    NSLog(@"%@", user.username);
    cell.titleLabel.text = user.username;
    cell.summary.text = @"Some summary about this guy";
    NSInteger num = (indexPath.row % 3) + 1;
    NSString *filename = [NSString stringWithFormat:@"profile%ld.jpg", num];
    cell.profileImage.image = [UIImage imageNamed:filename];
    cell.statusView.backgroundColor = [UIColor lightGrayColor];
    cell.assignedLabel.hidden = YES;
    cell.dueDate.hidden = YES;
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;


    if([self.job isAssignedTo:user]){
        cell.assignButton.enabled = NO;
        [cell.assignButton setTitle:@"Assigned" forState:UIControlStateNormal];
    } else {
        cell.assignButton.enabled = YES;
        [cell.assignButton setTitle:@"Assign" forState:UIControlStateNormal];
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


@end
