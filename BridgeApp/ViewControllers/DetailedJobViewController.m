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
@property (weak, nonatomic) IBOutlet UIButton *messageButton;


@end

@implementation DetailedJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self setButtonState];
    
    self.jobTitleLabel.text = self.job.title;
    self.priceLabel.text = [NSString stringWithFormat:@"$%@", self.job.price];
    self.summaryLabel.text = self.job.jobDescription;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:self.job.dueDate];
    
    self.dueDateLabel.text = stringFromDate;
    
    self.threadsTableView.delegate = self;
    self.threadsTableView.dataSource = self;
    self.threadsTableView.rowHeight = UITableViewAutomaticDimension;
    [self.threadsTableView registerNib:[UINib nibWithNibName:@"ThreadCell" bundle:nil] forCellReuseIdentifier:@"ThreadCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ThreadCell *cell = [self.threadsTableView dequeueReusableCellWithIdentifier:@"ThreadCell"];

    return cell;
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
    self.editButton.enabled = NO;
    self.deliverButton.enabled = NO;
    
    // disable certain buttons if applicable
    if ([self.job hasUserApplied:[User currentUser]]) {
        [self setAppliedButton];
    }
}
- (void)setAppliedButton {
    self.applyButton.enabled = NO;
    [self.applyButton setTitle:@"Applied" forState:UIControlStateNormal];
}

- (DetailedJobViewController *)initWithJob:(Job *)job {
    self.job = job;
    return self;
}
- (IBAction)onApply:(id)sender {
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
- (IBAction)onMessage:(id)sender {
    
}

@end
