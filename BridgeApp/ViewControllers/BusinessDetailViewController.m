//
//  BusinessDetailViewController.m
//  BridgeApp
//
//  Created by Shrikar Archak on 3/8/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "BusinessDetailViewController.h"
#import "Constants.h"
#import "BusinessCell.h"

@interface BusinessDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobDescription;
@property (weak, nonatomic) IBOutlet UILabel *dueDate;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BusinessDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.titleLabel.text = self.job[TITLE];
    self.jobDescription.text = self.job[SUMMARY];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Applicants";
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    return cell;
}
@end
