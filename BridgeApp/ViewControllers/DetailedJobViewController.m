//
//  DetailedJobViewController.m
//  BridgeApp
//
//  Created by David Tong on 3/7/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "DetailedJobViewController.h"
#import "ConversationThread.h"
#import "ThreadCell.h"
#import "MessagesViewController.h"
#import "ChatMessageThread.h"
#import "BusinessOwnerCell.h"
#import "ChameleonFramework/Chameleon.h"
#import "FreelancerProfileViewController.h"
#import "BusinessProfileViewController.h"
#import "POP/POP.h"

@interface DetailedJobViewController ()

@property (strong, nonatomic) Job* job;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *dueDateLabel;

@property (weak, nonatomic) IBOutlet UITableView *threadsTableView;
@property (weak, nonatomic) IBOutlet UIButton *applyButton;
@property (weak, nonatomic) IBOutlet UIButton *deliverButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;



@end

@implementation DetailedJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self setButtonState];
    self.threadsTableView.backgroundColor = [UIColor flatWhiteColor];
    self.titleLabel.text = self.job.title;
    self.priceLabel.text = [NSString stringWithFormat:@"$%@", self.job.price];
    self.summaryLabel.text = self.job.jobDescription;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:self.job.dueDate];
    
    self.dueDateLabel.text = stringFromDate;

    self.threadsTableView.backgroundColor = HEADERBARCOLOR;
    self.view.backgroundColor = TABLEVIEWCELLCOLOR;

    self.threadsTableView.delegate = self;
    self.threadsTableView.dataSource = self;
    self.threadsTableView.rowHeight = UITableViewAutomaticDimension;
    self.threadsTableView.estimatedRowHeight = 72;
    

    if(![self.job.assignedToUser.username isEqual:[User currentUser].username ]){
        self.applyButton.backgroundColor = NAVBARCOLOR;
    } else {
        self.applyButton.backgroundColor = [UIColor flatGrayColor];
        self.deliverButton.backgroundColor = NAVBARCOLOR;
    }
    [self.threadsTableView registerNib:[UINib nibWithNibName:@"BusinessOwnerCell" bundle:nil] forCellReuseIdentifier:@"BusinessOwnerCell"];

    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
}

-(void) back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessOwnerCell *cell = [self.threadsTableView dequeueReusableCellWithIdentifier:@"BusinessOwnerCell"];
    cell.businessName.text = self.job.owner.businessName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.ratingView.rating = 3.25;
    cell.ratingView.starSize = 15;
    cell.ratingView.starFillColor = [UIColor orangeColor];
    cell.backgroundColor = TABLEVIEWCELLCOLOR;
    cell.profileImageView.image = [UIImage imageNamed:self.job.owner.profileImageURL];
    cell.delegate = self;
    return cell;
}

-(void)goToProfile {
    FreelancerProfileViewController *fvc = [[FreelancerProfileViewController alloc] initWithUser:[User currentUser]];
    [self.navigationController pushViewController:fvc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setButtonState {
    self.applyButton.enabled = YES;
//    self.editButton.enabled = NO;
//    self.deliverButton.enabled = NO;

    // disable certain buttons if applicable
    if ([self.job hasUserApplied:[User currentUser]]) {
        [self setAppliedButton];
    }
}
- (void)setAppliedButton {
    self.applyButton.enabled = NO;
    [self.applyButton setTitle:@"Applied" forState:UIControlStateNormal];
}

- (void)setDeliveredButton {
    self.deliverButton.enabled = NO;
    [self.deliverButton setTitle:@"Delivered" forState:UIControlStateNormal];
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Conversations";
}


- (DetailedJobViewController *)initWithJob:(Job *)job {
    self.job = job;
    return self;
}

- (IBAction)onApply:(id)sender {
    self.job.status = JobStatusHasApplicants;

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
    
    [self.applyButton pop_addAnimation:scale forKey:@"scale"];
    [self.applyButton pop_addAnimation:scaledown forKey:@"scaledown"];
    
    [scaledown setCompletionBlock:^(POPAnimation *anim, BOOL completed) {
        [self.applyButton pop_removeAnimationForKey:@"scale"];
        [self.applyButton pop_removeAnimationForKey:@"scaledown"];
    }];

    
    [self.job addApplicant:[User currentUser]];
    [self.job saveWithCompletion:^(NSError *error) {
        if (error == nil) {
            NSLog(@"job applied successfully");
            PFInstallation *installation = [PFInstallation currentInstallation];
            installation[@"user"] = [PFUser currentUser];
            [installation saveInBackground];
        } else {
            NSLog(@"job application failed: %@", error);
        }
    }];
    
    /* Add the current user to the installation object */
    PFInstallation *installation = [PFInstallation currentInstallation];
    installation[@"freelancerid"] = [User currentUser].objectId;
    [installation saveInBackground];

    // Create our Installation query
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"ownerid" equalTo:self.job.owner.objectId];
    
    // Send push notification to query
    PFPush *push = [[PFPush alloc] init];
    [push setQuery:pushQuery]; // Set our Installation query
    User *curr = [User currentUser];
    NSString *message = [NSString stringWithFormat:@"%@ applied to %@", curr.username, self.job.title];
    [push setMessage:message];
    [push sendPushInBackground];
    [self setAppliedButton];
    [[NSNotificationCenter defaultCenter] postNotificationName:JOBSTATUSCHANGED object:nil userInfo:nil];    
}

- (IBAction)onDeliver:(id)sender {
    self.job.status = JobStatusDelivered;
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
    
    [self.deliverButton pop_addAnimation:scale forKey:@"scale"];
    [self.deliverButton pop_addAnimation:scaledown forKey:@"scaledown"];
    
    [scaledown setCompletionBlock:^(POPAnimation *anim, BOOL completed) {
        [self.deliverButton pop_removeAnimationForKey:@"scale"];
        [self.deliverButton pop_removeAnimationForKey:@"scaledown"];
    }];

    
    [self.job saveWithCompletion:^(NSError *error) {
        if (error == nil) {
            NSLog(@"job delivered successfully");
        } else {
            NSLog(@"job delivery failed: %@", error);
        }
    }];
    
    [self setDeliveredButton];
    // Create our Installation query
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"ownerid" equalTo:self.job.owner.objectId];
    
    // Send push notification to query
    PFPush *push = [[PFPush alloc] init];
    [push setQuery:pushQuery]; // Set our Installation query
    User *curr = [User currentUser];
    NSString *message = [NSString stringWithFormat:@"%@ delivered job %@", curr.username, self.job.title];
    [push setMessage:message];
    [push sendPushInBackground];
    [[NSNotificationCenter defaultCenter] postNotificationName:JOBSTATUSCHANGED object:nil userInfo:nil];
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessagesViewController *mvc = [[MessagesViewController alloc] init];
    mvc.fromUser = [User currentUser];
    NSArray *objectIds = @[self.job.owner.objectId, mvc.fromUser.objectId];
    [User getUserMap:objectIds completion:^(NSMutableDictionary *dict, NSError *error) {
        mvc.avatars = dict;
        [ChatMessageThread createMessageThread:self.job.objectId businessId:self.job.owner.objectId freelancerId:mvc.fromUser.objectId completion:^(NSString *threadID, NSError *error) {
            NSLog(@"### Thread id :%@", threadID);
            mvc.threadId = threadID;
            [self.navigationController pushViewController:mvc animated:YES];
        }];
        
    }];

    
}

-(void) businessOwnerCell:(BusinessOwnerCell *)businessOwnerCell{

    User *user = self.job.owner;
    BusinessProfileViewController *bpvc = [[BusinessProfileViewController alloc] init];
    bpvc.user = user;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:bpvc];    
    [self presentViewController:nvc animated:YES completion:nil];

}

@end
