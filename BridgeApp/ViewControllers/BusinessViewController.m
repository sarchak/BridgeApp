//
//  BusinessViewController.m
//  BridgeApp
//
//  Created by Shrikar Archak on 3/7/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "BusinessViewController.h"
#import "BusinessCell.h"
#import "Parse/Parse.h"
#import "Job.h"
#import "CreateJobScene1ViewController.h"
#import "BusinessDetailViewController.h"
#import "SVProgressHUD.h"
#import "ChameleonFramework/Chameleon.h"
#import "BusinessProfileViewController.h"
#import "FreelancerProfileViewController.h"
#import "Pop/Pop.h"
#import "RKDropdownAlert.h"

@interface BusinessViewController () <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSArray *assignedJobs;
@property (strong, nonatomic) NSArray *readyToAssignJobs;
@property (strong, nonatomic) NSArray *pendingJobs;
@property (assign, nonatomic) BOOL isPresenting;
@property (assign, nonatomic) double animationDuration;
@property (strong, nonatomic) BusinessCell *selectedCell;
@property (strong, nonatomic) NSDateFormatter *formatter;
@end

@implementation BusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animationDuration = 0.5;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;

    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateFormat:@"MM/dd/yyyy"];

    
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createJob)];

    
    [self fetchData];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTable) name:JOBSTATUSCHANGED object:nil];

    self.title = @"Bridge";
    self.tableView.backgroundColor = HEADERBARCOLOR;
    self.tableView.tableFooterView.hidden = YES;
    self.tableView.tableHeaderView.hidden = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

-(void) back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    // 1. The view for the header
//    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
//    
//    // 2. Set a custom background color and a border
//    headerView.backgroundColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
////    headerView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:1.0].CGColor;
////    headerView.layer.borderWidth = 1.0;
//    
////    // 3. Add a label
////    UILabel* headerLabel = [[UILabel alloc] init];
////    headerLabel.frame = CGRectMake(5, 2, tableView.frame.size.width - 5, 22);
////    headerLabel.backgroundColor = [UIColor clearColor];
////    headerLabel.textColor = [UIColor whiteColor];
////    headerLabel.font = [UIFont boldSystemFontOfSize:16.0];
////    headerLabel.text = @"This is the custom header view";
////    headerLabel.textAlignment = NSTextAlignmentLeft;
////    
////    // 4. Add the label to the header view
////    [headerView addSubview:headerLabel];
//    
//    // 5. Finally return
//    return headerView;
//}

-(void) businessProfile{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) refreshTable {
    [self fetchData];
}


-(void) fetchData {
    [SVProgressHUD show];

     /* Fetch assigned jobs */
    [Job getJobWithOptions:JobStatusDelivered completion:^(NSArray *foundObjects, NSError *error) {
        self.assignedJobs = foundObjects;
        [Job getJobWithOptions:JobStatusAssigned completion:^(NSArray *foundObjects, NSError *error) {
            NSMutableArray *tmp = [NSMutableArray arrayWithArray:self.assignedJobs];
            [tmp addObjectsFromArray:foundObjects];
            self.assignedJobs = [NSArray arrayWithArray:tmp];
            for(Job *tjob in self.assignedJobs){
                NSLog(@"Status : %ld",tjob.status);
            }
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
            
        }];
    }];
    
    /* Fetch ready to assign jobs. Jobs with applicants */
    [Job getJobWithOptions:JobStatusHasApplicants completion:^(NSArray *foundObjects, NSError *error) {
        self.readyToAssignJobs = foundObjects;
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }];

    [Job getJobWithOptions:JobStatusPendingAssignment completion:^(NSArray *foundObjects, NSError *error) {
        self.pendingJobs = foundObjects;
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
}

-(void) createJob{
    CreateJobScene1ViewController *cvc = [[CreateJobScene1ViewController alloc] init];
    cvc.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:cvc action:@selector(back)];
    
    self.title = @"Jobs";
    
    [self.navigationController pushViewController:cvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return self.assignedJobs.count;
    } else if(section == 1){
        return self.readyToAssignJobs.count;
    } else if(section == 2){
        return self.pendingJobs.count;
    }
    return 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return @"Assigned Jobs";
    }else if (section == 1) {
        return @"Ready to assign Jobs";
    }else if (section == 2) {
        return @"Unassigned Jobs";
    }
    return @"";
}


-(Job*) getJob: (NSIndexPath*) indexPath{
    Job *job = nil;
    if(indexPath.section == 0){
        job = self.assignedJobs[indexPath.row];
    } else if(indexPath.section == 1){
        job = self.readyToAssignJobs[indexPath.row];
    } else if(indexPath.section == 2){
        job = self.pendingJobs[indexPath.row];
    }
    return job;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessDetailViewController *bvc = [[BusinessDetailViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:bvc];
    bvc.job = [self getJob:indexPath];
    nvc.modalPresentationStyle = UIModalPresentationCustom;
    nvc.transitioningDelegate = self;
    
    self.selectedCell = (BusinessCell*)[tableView cellForRowAtIndexPath:indexPath];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:nvc animated:YES completion:nil];
    });

}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    cell.assignButton.hidden = YES;
    Job *job = [self getJob:indexPath];
    cell.titleLabel.text = job.title;
    cell.summary.text = job.jobDescription;
    NSInteger num = (indexPath.row % 3) + 1;
    
    
    // @TODO assign actual user object to cell.user!!
    cell.user = job.assignedToUser;
    
    if(indexPath.section == 0){
        NSString *filename = cell.user.profileImageURL;
        cell.profileImage.image = [UIImage imageNamed:filename];
        cell.statusView.backgroundColor = [UIColor flatGreenColor];
        cell.profileImage.hidden  = NO;
        cell.name.hidden = NO;
        cell.assignedLabel.hidden = NO;
        cell.name.text = job.assignedToUser.username;
  
    } else if(indexPath.section == 1){
        cell.profileImage.hidden  = YES;
        cell.statusView.backgroundColor = [UIColor flatYellowColorDark];
        cell.name.hidden = YES;
        cell.assignedLabel.hidden = YES;
    } else {
        cell.profileImage.hidden  = YES;
        cell.statusView.backgroundColor = [UIColor flatGrayColor];
        cell.name.hidden = YES;
        cell.assignedLabel.hidden = YES;
    }
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *stringFromDate = [self.formatter stringFromDate:job.dueDate];
    cell.dueDate.text = stringFromDate;
    cell.delegate = self;
    return cell;
}

#pragma Transitioning code



- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.isPresenting = YES;
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    self.isPresenting = NO;
    return self;
}



- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return self.animationDuration;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [toViewController.view setNeedsLayout];
    NSLog(@"Animation transition");
    if(self.isPresenting){
        toViewController.view.alpha = 0;
        toViewController.view.frame = self.selectedCell.frame;
        [UIView animateWithDuration:self.animationDuration animations:^{
            toViewController.view.alpha = 1;
            toViewController.view.frame = fromViewController.view.frame;
            [containerView addSubview:toViewController.view];
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        self.selectedCell.alpha = 0;

        [UIView animateWithDuration:self.animationDuration animations:^{
            fromViewController.view.alpha = 0;
            fromViewController.view.frame = self.selectedCell.frame;
            self.selectedCell.alpha = 1;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
            [fromViewController.view removeFromSuperview];
        }];
    }
}

-(void)onProfileTap:(User *)user {
    FreelancerProfileViewController * fpvc = [[FreelancerProfileViewController alloc] initWithUser:user];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:fpvc];

    [self presentViewController:nvc animated:YES completion:nil];

}

-(void)businessCell:(BusinessCell *)businessCell apply:(BOOL)value {
}



@end
