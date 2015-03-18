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
    
    self.threadsTableView.delegate = self;
    self.threadsTableView.dataSource = self;
    self.threadsTableView.rowHeight = UITableViewAutomaticDimension;
    self.threadsTableView.estimatedRowHeight = 72;
    [self.threadsTableView registerNib:[UINib nibWithNibName:@"BusinessOwnerCell" bundle:nil] forCellReuseIdentifier:@"BusinessOwnerCell"];

    self.applyButton.layer.cornerRadius = 5.0;
    self.editButton.layer.cornerRadius = 5.0;
    self.deliverButton.layer.cornerRadius = 5.0;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"user-male.png"] style:UIBarButtonItemStylePlain target:self action:@selector(goToProfile)];
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
    [self.job addApplicant:[User currentUser]];
    [self.job saveWithCompletion:^(NSError *error) {
        if (error == nil) {
            NSLog(@"job applied successfully");
        } else {
            NSLog(@"job application failed: %@", error);
        }
    }];
    [self setAppliedButton];
}

- (IBAction)onDeliver:(id)sender {
    self.job.status = JobStatusDelivered;
    [self.job saveWithCompletion:^(NSError *error) {
        if (error == nil) {
            NSLog(@"job delivered successfully");
        } else {
            NSLog(@"job delivery failed: %@", error);
        }
    }];
    [self setDeliveredButton];
    
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessagesViewController *mvc = [[MessagesViewController alloc] init];
    mvc.fromUser = [User currentUser];
    
    User *user = self.job.owner;
    
    [ChatMessageThread createMessageThread:self.job.objectId businessId:self.job.owner.objectId freelancerId:user.objectId completion:^(NSString *threadID, NSError *error) {
        NSLog(@"### Thread id :%@", threadID);
        mvc.threadId = threadID;
        [self.navigationController pushViewController:mvc animated:YES];
    }];
    
}


@end
