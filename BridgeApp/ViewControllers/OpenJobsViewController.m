//
//  OpenJobsViewController.m
//  BridgeApp
//
//  Created by David Tong on 3/7/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "OpenJobsViewController.h"
#import "Job.h"
#import "JobCell.h"
#import "BusinessCell.h"
#import "DetailedJobViewController.h"
#import "ChameleonFramework/Chameleon.h"

@interface OpenJobsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray* jobs;
@property (strong, nonatomic) NSArray* myJobs;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation OpenJobsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"JobCell" bundle:nil] forCellReuseIdentifier:@"JobCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];
    [self fetchData];
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(fetchData) forControlEvents:UIControlEventValueChanged];
    self.tableView.backgroundColor = [UIColor flatWhiteColor];

    
    NSLog(@"Now in ojvc, Current user: %@", [User currentUser].username);
}

-(void) fetchData {
    
    /* All  jobs */
    [Job getAllOpenJobs:^(NSArray *foundObjects, NSError *error) {
        self.jobs = foundObjects;
        NSMutableArray *array = [NSMutableArray arrayWithArray:foundObjects];
        [Job getJobWithOptions:JobStatusHasApplicants completion:^(NSArray *foundObjects, NSError *error) {
            [array addObjectsFromArray:foundObjects];
            self.jobs = [NSArray arrayWithArray:array];
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];            
        }];


    }];

    
   [Job getJobAssignedToUserWithStatus:[User currentUser] status:JobStatusAssigned completion:^(NSArray *foundObjects, NSError *error) {
       [self.refreshControl endRefreshing];
       self.myJobs = foundObjects;
       [self.tableView reloadData];
   }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    Job* job = nil;
    if(indexPath.section == 0){
        job = self.myJobs[indexPath.row];
        cell.statusView.backgroundColor = [UIColor flatGreenColor];
    } else {
        job = self.jobs[indexPath.row];
        cell.statusView.backgroundColor = [UIColor flatGrayColor];
    }
    cell.assignButton.hidden = YES;
    cell.titleLabel.text = job.title;
    cell.summary.text = job.jobDescription;
    cell.name.hidden = YES;
    cell.assignedLabel.hidden = YES;
    cell.profileImage.hidden  = YES;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return @"Your Jobs";
    }
    return @"Available Jobs";
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return self.myJobs.count;
    }
    return self.jobs.count;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Job *currentJob = nil;

    if(indexPath.section == 0){
        currentJob = self.myJobs[indexPath.row];
    } else {
        currentJob = self.jobs[indexPath.row];
    }

    DetailedJobViewController *djvc = [[DetailedJobViewController alloc] initWithJob:currentJob];
    [self.navigationController pushViewController:djvc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
