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

@interface BusinessViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSArray *jobs;
@end

@implementation BusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
}

-(void) refreshTable {
    [self fetchData];
}

-(void) fetchData {
//    Job *job = [[Job alloc] init];
//    [job findWithCompletion:nil sortOptions:nil completion:^(NSArray *foundObjects, NSError *error) {
//        self.jobs = foundObjects;
//        NSLog(@"%@", self.jobs);
//        [self.refreshControl endRefreshing];
//        [self.tableView reloadData];
//    }];

    PFQuery *query = [PFQuery queryWithClassName:@"Jobs"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.jobs = objects;
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
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

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.jobs.count;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessDetailViewController *bvc = [[BusinessDetailViewController alloc] init];
    bvc.job = self.jobs[indexPath.row];
    [self.navigationController pushViewController:bvc animated:YES];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
//    Job *job = self.jobs[indexPath.row];
//    NSLog(@"Title : %@", job.title);
//    cell.titleLabel.text = job.title;
    
    PFObject *job = self.jobs[indexPath.row];
    NSLog(@"Title : %@", job[TITLE]);
    cell.titleLabel.text = job[TITLE];
    cell.summary.text = job[SUMMARY];
    NSInteger num = (indexPath.row % 3) + 1;
    NSString *filename = [NSString stringWithFormat:@"profile%ld.jpg", num];
    cell.profileImage.image = [UIImage imageNamed:filename];
    return cell;
}
@end
