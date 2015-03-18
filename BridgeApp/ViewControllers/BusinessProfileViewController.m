//
//  BusinessProfileViewController.m
//  BridgeApp
//
//  Created by Shrikar Archak on 3/17/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "BusinessProfileViewController.h"
#import "BusinessCell.h"
#import "Job.h"
#import "ChameleonFramework/Chameleon.h"
#import "SVProgressHUD.h"

@interface BusinessProfileViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *completedJobs;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation BusinessProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;

    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(fetchData) forControlEvents:UIControlEventValueChanged];
    [self fetchData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchData) name:JOBSTATUSCHANGED object:nil];
}

-(void) fetchData {
    [SVProgressHUD show];
    
    /* Fetch assigned jobs */
    [Job getJobWithOptions:JobStatusAccepted completion:^(NSArray *foundObjects, NSError *error) {
        self.completedJobs = foundObjects;
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.completedJobs.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return @"Completed Jobs";
    }
    return @"";
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    Job *job = self.completedJobs[indexPath.row];
    cell.assignButton.hidden = YES;
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
@end
