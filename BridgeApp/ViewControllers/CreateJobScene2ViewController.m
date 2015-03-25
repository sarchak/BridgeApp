//
//  CreateJobScene2ViewController.m
//  BridgeApp
//
//  Created by Shrikar Archak on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "CreateJobScene2ViewController.h"
#import "TitleSubtitleCell.h"
#import "TextViewController.h"
#import "Constants.h"
#import "THDatePickerViewController.h"
#import "PriceViewController.h"
#import "ParseClient.h"
#import "Parse/Parse.h"
#import "BusinessViewController.h"
#import "Pop/Pop.h"
#import "RKDropdownAlert.h"
#import "BusinessDetailViewController.h"
#import "ChameleonFramework/Chameleon.h"

@interface CreateJobScene2ViewController () <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) THDatePickerViewController * datePicker;
@property (nonatomic, retain) NSDate * curDate;
@property (nonatomic, retain) NSDateFormatter * formatter;
@property (nonatomic, assign) BOOL isPresenting;
@property (nonatomic, assign) double animationDuration;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@end

@implementation CreateJobScene2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleSubtitleCell" bundle:nil] forCellReuseIdentifier:@"TitleSubtitleCell"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.animationDuration = 0.3;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.job = [[Job alloc] init];
    self.job.category = self.category;
    self.job.owner = [User currentUser];
    self.job.status = JobStatusPendingAssignment;
    NSLog(@"Dictionary : %@", self.job);
    
    /* Configure date picker */
    self.curDate = [NSDate date];

    self.view.backgroundColor = TABLEVIEWCELLCOLOR;
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];

    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateFormat:@"MM/dd/yyyy"];
    self.title = self.job.title;

    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithTitle:@"Preview" style:UIBarButtonItemStyleDone target:self action:@selector(preview)];

}

-(void) preview {
    
    if(self.job.title == nil){
        [RKDropdownAlert title:@"Title Missing" message:@"Please provide a title and summary" backgroundColor:[UIColor flatRedColor] textColor:[UIColor whiteColor] time:1];
    } else if(self.job.jobDescription == nil){
        [RKDropdownAlert title:@"Job Description" message:@"Please provide a job description" backgroundColor:[UIColor flatRedColor] textColor:[UIColor whiteColor] time:1];
    } else {
        BusinessDetailViewController *bdvc = [[BusinessDetailViewController alloc] init];
        bdvc.job = self.job;
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:bdvc];
        [self presentViewController:nvc animated:YES completion:nil];
    }
}

-(void) back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TextViewController *tvc = [[TextViewController alloc] init];
    tvc.job = self.job;
    tvc.delegate = self;
    UINavigationController *nvc = nil;
    if(indexPath.row == 0){
        tvc.isTitle = YES;
        nvc = [[UINavigationController alloc] initWithRootViewController:tvc];
        nvc.modalPresentationStyle = UIModalPresentationCustom;
        nvc.transitioningDelegate = self;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self presentViewController:nvc animated:YES completion:nil];
        });

        
        
    } else if(indexPath.row == 1) {
        tvc.isTitle = NO;
        nvc = [[UINavigationController alloc] initWithRootViewController:tvc];
        nvc.modalPresentationStyle = UIModalPresentationCustom;
        nvc.transitioningDelegate = self;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self presentViewController:nvc animated:YES completion:nil];
        });

    } else if(indexPath.row == 2) {
        [self showCalendarView];
    } else if(indexPath.row == 3){
        PriceViewController *pvc = [[PriceViewController alloc] init];
        pvc.job = self.job;
        pvc.delegate = self;
        nvc = [[UINavigationController alloc] initWithRootViewController:pvc];
        nvc.modalPresentationStyle = UIModalPresentationCustom;
        nvc.transitioningDelegate = self;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self presentViewController:nvc animated:YES completion:nil];
        });

    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}

-(void) titleSubtitleCell:(TitleSubtitleCell *)cell iconTapped:(BOOL)tapped{
    NSLog(@"Calendar icon tapped");
//    [self showCalendarView];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TitleSubtitleCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TitleSubtitleCell"];
    cell.subTitleLabel.hidden = NO;
    switch (indexPath.row) {
        case 0: if(self.job.title != nil && ![self.job.title isEqual:@""]){
                    cell.titleLabel.text =self.job.title;
                    cell.subTitleLabel.hidden = YES;
                } else {
                    cell.titleLabel.text =@"Write Title";
                    cell.subTitleLabel.text = @"Give your job a descriptive headline.";
                }
                break;
        case 1: if(self.job.jobDescription != nil && ![self.job.jobDescription isEqual:@""]){
                    cell.titleLabel.text = self.job.jobDescription;
                    cell.subTitleLabel.hidden = YES;
                } else {
                    cell.titleLabel.text =@"Write Summary";
                    cell.subTitleLabel.text = @"Summarize the highlights of your job.";
                }
                break;
        case 2: if(self.job.dueDate != nil){
                    NSString *stringFromDate = [self.formatter stringFromDate:self.job.dueDate];
                    cell.titleLabel.text = [NSString stringWithFormat:@"Due Date: %@",stringFromDate];
                    cell.subTitleLabel.hidden = YES;
                } else {
                    cell.titleLabel.text =@"Select a due date";
                    cell.subTitleLabel.text = @"When do you want the job to be completed by.";                    
                }
            break;
        case 3: if(self.job.price != nil){
                    cell.titleLabel.text = [NSString stringWithFormat:@"Price in $: %@",self.job.price];
                    cell.subTitleLabel.hidden = YES;
                } else {
                    cell.titleLabel.text =@"Set Price";
                    cell.subTitleLabel.text = @"Price you are willing to pay for this job.";
                }
            break;
            
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
}

#pragma DatePicker

-(void) showCalendarView{
    if(!self.datePicker)
        self.datePicker = [THDatePickerViewController datePicker];
    self.datePicker.date = self.curDate;
    self.datePicker.delegate = self;
    [self.datePicker setAllowClearDate:NO];
    [self.datePicker setClearAsToday:YES];
    [self.datePicker setAutoCloseOnSelectDate:NO];
    [self.datePicker setAllowSelectionOfSelectedDate:YES];
    [self.datePicker setDisableHistorySelection:YES];
    [self.datePicker setDisableFutureSelection:NO];
    //[self.datePicker setAutoCloseCancelDelay:5.0];
    [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:125/255.0 green:208/255.0 blue:0/255.0 alpha:1.0]];
    [self.datePicker setCurrentDateColor:[UIColor colorWithRed:242/255.0 green:121/255.0 blue:53/255.0 alpha:1.0]];
    [self.datePicker setCurrentDateColorSelected:[UIColor yellowColor]];
    
    [self.datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
        int tmp = (arc4random() % 30)+1;
        return (tmp % 5 == 0);
    }];
    [self presentSemiViewController:self.datePicker withOptions:@{
                                                                  KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                                  KNSemiModalOptionKeys.animationDuration : @(0.2),
                                                                  KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                                  }];
}


-(BOOL) validateJob{
    if(self.job.title != nil && self.job.jobDescription != nil && self.job.price != nil && self.job.dueDate != nil){
        return true;
    }
    return false;
}
- (IBAction)createJob:(id)sender {
    
    POPSpringAnimation *scale =
    [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scale.toValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.2)];
    scale.springBounciness = 5;
    scale.springSpeed = 2.0f;
    scale.velocity= [NSValue valueWithCGSize:CGSizeMake(5.f, 5.f)];
    POPSpringAnimation *scaledown =
    [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scaledown.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    scaledown.springBounciness = 5;
    scaledown.springSpeed = 3.0f;
    scaledown.velocity= [NSValue valueWithCGSize:CGSizeMake(5.f, 5.f)];
    
    [self.createButton pop_addAnimation:scale forKey:@"scale"];
    [self.createButton pop_addAnimation:scaledown forKey:@"scaledown"];
    
    [scaledown setCompletionBlock:^(POPAnimation *anim, BOOL completed) {
        [self.createButton pop_removeAnimationForKey:@"scale"];
        [self.createButton pop_removeAnimationForKey:@"scaledown"];
    }];
    
    if([self validateJob]){
        self.job.owner = [User currentUser];
        [self.job saveWithCompletion:^(NSError *error) {
            NSLog(@"Save with completion : %@", error);
            self.job.category = self.category;
            self.job.owner = [User currentUser];
            self.job.status = JobStatusPendingAssignment;
            [[NSNotificationCenter defaultCenter] postNotificationName:JOBSTATUSCHANGED object:nil userInfo:nil];
            
            PFInstallation *installation = [PFInstallation currentInstallation];
            installation[@"ownerid"] = [PFUser currentUser].objectId;
            [installation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                UIViewController* viewcontroller = [self.navigationController.viewControllers objectAtIndex:1];
                [self.navigationController popToViewController:viewcontroller animated:YES];
                [RKDropdownAlert title:@"Job Created!" message:self.job.title backgroundColor:[UIColor flatGreenColor] textColor:[UIColor whiteColor] time:3];
                self.job = [[Job alloc] init];
            }];
            
        }];
        
    } else {
        [RKDropdownAlert title:@"Cannot create Job." message:@"Please provide title,summary, price and due date" backgroundColor:[UIColor flatRedColor] textColor:[UIColor whiteColor] time:1];
    }
    
}


- (void)datePickerDonePressed:(THDatePickerViewController *)datePicker {
    self.curDate = datePicker.date;
    //[self.datePicker slideDownAndOut];
    [self dismissSemiModalView];
}


- (void)datePickerCancelPressed:(THDatePickerViewController *)datePicker {
    //[self.datePicker slideDownAndOut];
    [self dismissSemiModalView];
}

- (void)datePicker:(THDatePickerViewController *)datePicker selectedDate:(NSDate *)selectedDate {
    NSLog(@"Date selected: %@",[_formatter stringFromDate:selectedDate]);
    self.job.dueDate = selectedDate;
    [self.tableView reloadData];
}

-(void) displayJob{
    NSLog(@"Title : %@", self.job.title);
    NSLog(@"Summary : %@", self.job.jobDescription);
    NSLog(@"Due Date : %@", self.job.dueDate);
    NSLog(@"Price : %@", self.job.price);
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

    
    if(self.isPresenting){
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleAnimation.springBounciness = 8;
        [toViewController.view.layer pop_addAnimation:scaleAnimation forKey:@"scale"];
        [containerView addSubview:toViewController.view];
        [scaleAnimation setCompletionBlock:^(POPAnimation * animation, BOOL completed) {
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


-(void) textViewController:(TextViewController *)textViewController valueChanged:(BOOL)value{
    [self.tableView reloadData];
}

-(void) priceViewController:(PriceViewController *)priceViewController valueChanged:(BOOL)value{
    [self.tableView reloadData];
}

@end
