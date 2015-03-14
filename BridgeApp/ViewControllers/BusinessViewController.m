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

#import "ChameleonFramework/Chameleon.h"
@interface BusinessViewController () <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSArray *assignedJobs;
@property (strong, nonatomic) NSArray *readyToAssignJobs;
@property (strong, nonatomic) NSArray *pendingJobs;
@property (assign, nonatomic) BOOL isPresenting;
@property (assign, nonatomic) double animationDuration;
@end

@implementation BusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animationDuration = 0.2;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createJob)];

    [self fetchData];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTable) name:JOBSTATUSCHANGED object:nil];

    self.title = @"Bridge";
    self.tableView.backgroundColor = [UIColor flatWhiteColor];
    /*
     * ATTENTION!!
     * This should be the same as DetailedJobViewController
     * Please merge with DetailedJobViewController. They should look pretty much the same.
     * Except for different conversation threads and buttons (apply, deliver, edit).
     *
     *
     */
}

-(void) refreshTable {
    [self fetchData];
}


-(void) fetchData {
    
     /* Fetch assigned jobs */
    [Job getJobWithOptions:JobStatusAssigned completion:^(NSArray *foundObjects, NSError *error) {
        self.assignedJobs = foundObjects;
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }];
    
    /* Fetch ready to assign jobs. Jobs with applicants */
    [Job getJobWithOptions:JobStatusHasApplicants completion:^(NSArray *foundObjects, NSError *error) {
        self.readyToAssignJobs = foundObjects;
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }];

    [Job getJobWithOptions:JobStatusPendingAssignment completion:^(NSArray *foundObjects, NSError *error) {
        self.pendingJobs = foundObjects;
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
        
        for(Job *tjob in foundObjects){
            NSLog(@"#### %@ ", tjob.title);
            for(User *applicant in tjob.applicants){
                NSLog(@"@@@@ user %@", applicant.username);
            }
        }
    }];
}

-(void) createJob{
    CreateJobScene1ViewController *cvc = [[CreateJobScene1ViewController alloc] init];
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
    bvc.job = [self getJob:indexPath];
    [self.navigationController pushViewController:bvc animated:YES];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    cell.assignButton.hidden = YES;
    Job *job = [self getJob:indexPath];
    cell.titleLabel.text = job.title;
    cell.summary.text = job.jobDescription;
    NSInteger num = (indexPath.row % 3) + 1;
    if(indexPath.section == 0){
        NSString *filename = [NSString stringWithFormat:@"profile%ld.jpg", num];
        cell.profileImage.image = [UIImage imageNamed:filename];
        cell.statusView.backgroundColor = [UIColor flatGreenColor];
        cell.profileImage.hidden  = NO;
        cell.name.hidden = NO;
        cell.assignedLabel.hidden = NO;
        
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

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

//- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator;
//
//- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator;

//- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0);



- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return self.animationDuration;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if(self.isPresenting){
        [containerView addSubview:toViewController.view];
        toViewController.view.alpha = 0;
        toViewController.view.transform = CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:self.animationDuration animations:^{
            toViewController.view.alpha = 1;
//            toViewController.view.frame = fromViewController.view.frame;
            toViewController.view.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        [UIView animateWithDuration:self.animationDuration animations:^{
            fromViewController.view.alpha = 0;
//            fromViewController.view.transform = CGAffineTransformMakeScale(0.001, 0.001);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
            [fromViewController.view removeFromSuperview];
        }];
    }
}

@end
