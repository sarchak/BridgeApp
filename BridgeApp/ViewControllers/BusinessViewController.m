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
#import "Pop/Pop.h"
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
    self.animationDuration = 1.4;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createJob)];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(businessProfile)];
    
    [self fetchData];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTable) name:JOBSTATUSCHANGED object:nil];

    self.title = @"Bridge";
    self.tableView.backgroundColor = [UIColor flatWhiteColor];
}

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



- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return self.animationDuration;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSLog(@"Animation transition");
    if(self.isPresenting){
//        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBounds];
//        anim.fromValue = [NSValue valueWithCGRect:fromViewController.view.bounds];
//        anim.toValue = [NSValue valueWithCGRect:containerView.bounds];
//        anim.springBounciness = 5;
//        anim.springSpeed = 10;
        
        POPBasicAnimation *basicAnimation = [POPBasicAnimation animation];
        basicAnimation.property = [POPAnimatableProperty propertyWithName:kPOPLayerSize];
        basicAnimation.toValue= [NSValue valueWithCGSize:toViewController.view.frame.size];
        basicAnimation.fromValue= [NSValue valueWithCGSize:fromViewController.view.frame.size];
        [toViewController.view.layer pop_addAnimation:basicAnimation forKey:@"size"];
        
        POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        opacityAnimation.toValue = @(1.0);
        [toViewController.view.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
        
//        POPBasicAnimation *opacity = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
//        opacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        opacity.fromValue = @(0.0);
//        opacity.toValue = @(1.0);
//        [toViewController.view pop_addAnimation:opacity forKey:@"fade"];
        
        [containerView addSubview:toViewController.view];
        
        [opacityAnimation setCompletionBlock:^(POPAnimation * animation, BOOL completed) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        
        POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        opacityAnimation.toValue = @(0.0);
        [opacityAnimation setCompletionBlock:^(POPAnimation *anim, BOOL completed) {
            [transitionContext completeTransition:YES];
            [fromViewController.view removeFromSuperview];
        }];
        [fromViewController.view.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    }
}




@end
