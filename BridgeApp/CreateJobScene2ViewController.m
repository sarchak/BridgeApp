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

@interface CreateJobScene2ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CreateJobScene2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleSubtitleCell" bundle:nil] forCellReuseIdentifier:@"TitleSubtitleCell"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TextViewController *tvc = [[TextViewController alloc] init];
    [self.navigationController pushViewController:tvc animated:YES];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TitleSubtitleCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TitleSubtitleCell"];

    switch (indexPath.row) {
        case 0: cell.titleLabel.text =@"Write Title";
                cell.subTitleLabel.text = @"Give your job a descriptive headline.";
                break;
        case 1: cell.titleLabel.text =@"Write Summary";
            cell.subTitleLabel.text = @"Summarize the highlights of your job.";
            break;
        case 2: cell.titleLabel.text =@"Select a due date";
            cell.subTitleLabel.text = @"When do you want the job to be completed by.";
            break;
        case 3: cell.titleLabel.text =@"Set Price";
            cell.subTitleLabel.text = @"Price you are willing to pay for this job.";
            break;
            
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
@end
