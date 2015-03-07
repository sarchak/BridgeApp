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
#import "DetailedJobViewController.h"

@interface OpenJobsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray* jobs;

@end

@implementation OpenJobsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"JobCell" bundle:nil] forCellReuseIdentifier:@"JobCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JobCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JobCell"];
    
    cell.job = self.jobs[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;//self.jobs.count;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Job *currentJob = self.jobs[indexPath.row];
    
    currentJob.title = [NSString stringWithFormat:@"Logo needed for %d", (int)indexPath.row];
    
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
